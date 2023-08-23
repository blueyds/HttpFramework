import Foundation

public struct SWAPI_Person: Hashable, Codable {
    public var name: String
    public var _birth_year: String
    public var eye_color: String
    public var gender: String
    public var hair_color: String
    public var _height: String
    public var mass: String
    public var skin_color: String
    public var homeworld: String
    public var films: [String]
    public var species: [String]
    public var starships: [String]
    public var vehicles: [String]
    public var url: String
    public var created: String
    public var edited: String
	public lazy var height: Double = Double(_height) ?? 0.0
	 
	 enum codingKeys: String, CodingKey{
		 case name
		 case birth_year
		 case eye_color
		 case gender
		 case hair_color
		 case height = "_height"
		 case mass
		 case skin_color
		 case homeworld
		 case films
		 case starships
		 case vehicles
		 case url
		 case created
		 case edited
	 }
	 
}
/*
 name string -- The name of this person.
 birth_year string -- The birth year of the person, using the in-universe standard of BBY or ABY - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is a battle that occurs at the end of Star Wars episode IV: A New Hope.
 eye_color string -- The eye color of this person. Will be "unknown" if not known or "n/a" if the person does not have an eye.
 gender string -- The gender of this person. Either "Male", "Female" or "unknown", "n/a" if the person does not have a gender.
 hair_color string -- The hair color of this person. Will be "unknown" if not known or "n/a" if the person does not have hair.
 height string -- The height of the person in centimeters.
 mass string -- The mass of the person in kilograms.
 skin_colr string -- The skin color of this person.
 homeworld string -- The URL of a planet resource, a planet that this person was born on or inhabits.
 films array -- An array of film resource URLs that this person has been in.
 species array -- An array of species resource URLs that this person belongs to.
 starships array -- An array of starship resource URLs that this person has piloted.
 vehicles array -- An array of vehicle resource URLs that this person has piloted.
 url string -- the hypermedia URL of this resource.
 created string -- the ISO 8601 date format of the time that this resource was created.
 edited string -- the
 */

