require 'spec_helper'

module PrLog
  describe ParsedChangelog do
    describe '#mentioned_issue_numbers' do
      it 'returns array of issue numbers as strings' do
        contents = <<-TEXT.unindent
          # CHANGELOG

          ## Unreleased Changes

          - PR already described here
          ([#1](https://github.com/some/repo/pull/1))
          - PR already described here
          ([#2](http://github.com/some/repo/pull/2))
        TEXT
        changelog = ParsedChangelog.new(contents,
                                        github_repository: 'some/repo')

        result = changelog.mentioned_issue_numbers

        expect(result).to eq([1, 2])
      end

      it 'ignores mentioned prs of other repositories' do
        contents = <<-TEXT.unindent
          # CHANGELOG

          ## Unreleased Changes

          - PR already described here
          ([#1](https://github.com/other/repo/pull/1))
        TEXT
        changelog = ParsedChangelog.new(contents,
                                        github_repository: 'some/repo')

        result = changelog.mentioned_issue_numbers

        expect(result).to eq([])
      end
    end
  end
end
