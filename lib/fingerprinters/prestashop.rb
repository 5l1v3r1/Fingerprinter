# frozen_string_literal: true

# Prestashop
class Prestashop < Fingerprinter
  include IgnorePattern::PHP

  def downloadable_versions
    versions = {}
    page = Nokogiri::HTML(Typhoeus.get('https://www.prestashop.com/en/previous-versions').body)

    page.css('a.btn.btn-ghost-pink').each do |link|
      href = link['href'].strip

      next unless href =~ /prestashop_([0-9.]+)\.zip$/ # Only stable releases

      versions[Regexp.last_match[1]] = href
    end

    versions
  end

  def extract_archive(archive_path, dest)
    super(archive_path, dest)

    FileUtils.rm(File.join(dest, 'Install_PrestaShop.html'), force: true)

    sub_dir = Dir[File.join(dest, '*/')].first

    rebase(sub_dir, dest) if sub_dir =~ /\A#{dest}prestashop/i
  end
end
