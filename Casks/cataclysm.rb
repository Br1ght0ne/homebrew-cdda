#!/usr/bin/env ruby

cask "cataclysm" do
  version "2024-12-25-1535"
  sha256 :no_check

  url "https://github.com/CleverRaven/Cataclysm-DDA/releases/download/cdda-experimental-#{version}/cdda-osx-with-graphics-universal-#{version}.dmg"
  name "Cataclysm"
  desc "A turn-based survival game set in a post-apocalyptic world"
  homepage "https://github.com/CleverRaven/Cataclysm-DDA"

  livecheck do
    url :homepage
    regex(/^cdda-experimental-(\d{4}-\d{2}-\d{2}-\d{4})/)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next unless release["prerelease"]
  
        match = release["tag_name"]&.match(regex)
        next if match.blank?
  
        match[1]
      end
    end
  end

  app "Cataclysm.app"

  zap trash: [
    "~/Library/Application Support/Cataclysm",
  ]
end
