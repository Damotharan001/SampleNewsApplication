/* 
Copyright (c) 2025 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Results : Codable {
	let id : Int
	let title : String?
	let authors : [Authors]?
	let url : String?
	let image_url : String?
	let news_site : String?
	let summary : String?
	let published_at : String?
	let updated_at : String?
	let featured : Bool?
//	let launches : [String]?
//	let events : [String]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case authors = "authors"
		case url = "url"
		case image_url = "image_url"
		case news_site = "news_site"
		case summary = "summary"
		case published_at = "published_at"
		case updated_at = "updated_at"
		case featured = "featured"
//		case launches = "launches"
//		case events = "events"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		authors = try values.decodeIfPresent([Authors].self, forKey: .authors)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		news_site = try values.decodeIfPresent(String.self, forKey: .news_site)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
//		launches = try values.decodeIfPresent([String].self, forKey: .launches)
//		events = try values.decodeIfPresent([String].self, forKey: .events)
	}

}
