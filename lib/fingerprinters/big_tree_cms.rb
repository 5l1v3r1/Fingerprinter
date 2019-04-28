# frozen_string_literal: true

# Big Tree CNS
class BigTreeCms < Fingerprinter
  include GithubHosted
  include IgnorePattern::PHP

  def downloadable_versions
    github_releases('bigtreecms/BigTree-CMS') # , %r{/download/v?(?<v>[\d\.]+)/bolt\-v?[\d\.]+\.zip}i)
  end

  def extract_archive(archive_path, dest)
    super(archive_path, dest)

    rebase(File.join(dest, 'core'), dest)
  end
end
