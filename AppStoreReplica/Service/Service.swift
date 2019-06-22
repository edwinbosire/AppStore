import Foundation

// Poor Man's data service

struct DataLoaderService {
    static func load(completion: @escaping ([AppStoreCategory]?) -> Void ) {
        let data = Data(Store.AppStoreData.utf8)
        do {
            let decoder = JSONDecoder()
            let apps = try decoder.decode([AppStoreCategory].self, from: data)
            completion(apps)
        } catch (let e){
            print("Error parsing JSON \(e)")
        }
    }
    
    static func getBestNewApps() -> [App] {
        let data = Data(Store.AppStoreData.utf8)
        let decoder = JSONDecoder()
        let apps = try? decoder.decode([AppStoreCategory].self, from: data)
        return apps![1].apps
    }
}

struct Store {
    static let AppStoreData = """
[
  {
    "name": "",
    "apps": [
      {
        "Name": "Fox Factory",
        "ImageName": "foxFactory",
        "Category": "Entertainment",
        "Price": 3.99,
        "desc": "Learn to code with Fox",
        "note": "Our favourites"
      },
      {
        "Name": "Disney Build It: Frozen",
        "ImageName": "shadowmatic",
        "Category": "Entertainment",
        "Price": 3.99,
        "desc": "Stunning stories of friendship",
        "note": "Featured"
      },
      {
        "Name": "Disney Build It: Frozen",
        "ImageName": "indieGameBanner",
        "Category": "Entertainment",
        "Price": 3.99,
        "desc": "Make your world magical",
        "note": "Get inspired"
      },
      {
        "Name": "Disney Build It: Frozen",
        "ImageName": "luminocity",
        "Category": "Entertainment",
        "Price": 3.99,
        "desc": "They are bring back Bristleback",
        "note": "Try something new"
      }
    ],
    "layout": "largeGallery"
  },
  {
    "name": "Best New Apps",
    "apps": [
      {
        "Name": "Disney Build It: Frozen",
        "Category": "Entertainment",
        "Price": 3.99,
        "ImageName": "frozen",
        "desc" : "All new toys to play with"
      },
      {
        "Name": "Spot - the best places according to experts and friends",
        "Category": "Travel",
        "ImageName": "spot",
        "Price": 3.99,
        "desc" : "You might need to make friends first"
      },
      {
        "Name": "Dine - More Dates, Not Swipes",
        "Category": "Social Networking",
        "Price": 3.99,
        "ImageName": "dine",
        "desc" : "You can't get a date, thats why you are here"
      },
      {
        "Name": "Today: Habit tracker for your daily goals and routines",
        "Category": "Health & Fitness",
        "Price": 3.99,
        "ImageName": "today",
        "desc" : "Another app to track your failures"
      },
      {
        "Name": "Disney Build It: Frozen",
        "Category": "Entertainment",
        "Price": 3.99,
        "ImageName": "frozen",
        "desc" : "All the kids love it"
      },
      {
        "Name": "Spot - the best places according to experts and friends",
        "Category": "Travel",
        "Price": 3.99,
        "ImageName": "spot",
        "desc" : "Discover new places with friends"
      },
      {
        "Name": "Dine - More Dates, Not Swipes",
        "Category": "Social Networking",
        "Price": 3.99,
        "ImageName": "dine",
        "desc" : "You deserve better"
      },
      {
        "Name": "Today: Habit tracker for your daily goals and routines",
        "Category": "Health & Fitness",
        "Price": 3.99,
        "ImageName": "today",
        "desc" : "Make sure you achieve all your goals"
      }
    ],
    "layout": "mediumListGallery"
  },
  {
    "name": "Best New Games",
    "apps": [
      {
        "Name": "Telepaint",
        "Category": "Games",
        "Price": 2.99,
        "ImageName": "foxFactory"
      },
      {
        "Name": "Dirac",
        "Category": "Games",
        "Price": 1.99,
        "ImageName": "dirac"
      },
      {
        "Name": "Clash Royale",
        "Category": "Games",
        "ImageName": "clashroyale",
        "Price": 3.99
      },
      {
        "Name": "Beat Stomper",
        "Category": "Games",
        "Price": 1.99,
        "ImageName": "beatstomper"
      },
      {
        "Name": "Telepaint",
        "Category": "Games",
        "Price": 2.99,
        "ImageName": "telepaint"
      },
      {
        "Name": "Dirac",
        "Category": "Games",
        "Price": 1.99,
        "ImageName": "dirac"
      },
      {
        "Name": "Clash Royale",
        "Category": "Games",
        "ImageName": "clashroyale",
        "Price": 3.99
      },
      {
        "Name": "Beat Stomper",
        "Category": "Games",
        "Price": 1.99,
        "ImageName": "beatstomper"
      }
    ],
    "layout": "mediumGallery"
  },
  {
    "name": "50% Off for a Limited Time",
    "apps": [
      {
        "Name": "Luminocity",
        "ImageName": "luminocity",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "The Room",
        "ImageName": "theroom",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "Bad Land",
        "ImageName": "badland",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "Shadowmatic",
        "ImageName": "shadowmatic",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "Luminocity",
        "ImageName": "luminocity",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "Summoners War",
        "ImageName": "theroom",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "Summoners War",
        "ImageName": "badland",
        "Category": "Entertainment",
        "Price": 3.99
      },
      {
        "Name": "Summoners War",
        "ImageName": "shadowmatic",
        "Category": "Entertainment",
        "Price": 3.99
      }
    ],
    "layout": "mediumGallery"
  },
  {
    "name": "More Games You Might Like",
    "apps": [
      {
        "Name": "Summoners War",
        "Category": "Games",
        "ImageName": "summonerswar",
        "Price": 3.99
      },
      {
        "Name": "Angry Birds Space",
        "Category": "Games",
        "Price": 0.99,
        "ImageName": "angrybirdsspace",
        "Price": 3.99
      },
      {
        "Name": "Star War's Commander - Worlds in Conflict",
        "Category": "Games",
        "ImageName": "starwars",
        "Price": 3.99
      },
      {
        "Name": "Death Worm",
        "Category": "Games",
        "Price": 2.99,
        "ImageName": "deathworm",
        "Price": 3.99
      }
    ],
    "layout": "mediumListGallery"
  }
]


"""
    
}
