
Pod::Spec.new do |s|

  s.name         = "oxen"
  s.version      = "0.0.5"
  s.summary      = "Observable collections in Objective-C"

  s.description  = <<-DESC
  		 oxen generates changesets when collections are modified. The main use-case for observable collections 
		 are when binding a collection to a UITableView or a UICollectionView.

		 Oxen changesets include the types of changes made to the collection and a snapshot of the collection after 
		 the changes hace been completed, making it easy to 

                   DESC

  s.homepage     = "https://github.com/jacksonh/oxen"
  s.license      = "MIT"
  s.author             = { "Jackson Harper" => "jacksonh@gmail.com" }
  s.social_media_url   = "http://twitter.com/jacksonh"

  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/jacksonh/oxen.git", :tag => "0.0.5" }

  s.source_files  = "oxen/*.{h,m}"
  s.public_header_files = "oxen/*.h"

  s.requires_arc = true

end
