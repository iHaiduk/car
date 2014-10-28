class Static
  model_transmission_type: (req)->
    'Manual': req.__('Manual')
    'Automatic': req.__('Automatic')
    '4-speed manual': req.__('4-speed manual')
    '6-speed manual': req.__('6-speed manual')
    '6-speed automatic': req.__('6-speed automatic')
    '5-speed manual': req.__('5-speed manual')
    'Single Speed': req.__('Single Speed')
    'CVT': req.__('CVT')
    '7-speed automatic': req.__('7-speed automatic')
    '5-speed shiftable automatic': req.__('5-speed shiftable automatic')
    '6-speed automated manual': req.__('6-speed automated manual')
    '5-speed automated manual': req.__('5-speed automated manual')
    '8-speed shiftable automatic': req.__('8-speed shiftable automatic')
    '5-speed automatic': req.__('5-speed automatic')
    '4-speed automatic': req.__('4-speed automatic')
    '6-speed shiftable automatic': req.__('6-speed shiftable automatic')
    '7-speed shiftable automatic': req.__('7-speed shiftable automatic')
    '7-speed automated manual': req.__('7-speed automated manual')
    '8-speed automated manual': req.__('8-speed automated manual')
    '8-speed automatic': req.__('8-speed automatic')
    '4-speed shiftable automatic': req.__('4-speed shiftable automatic')
    '7-speed manual': req.__('7-speed manual')
    'Automated Manual': req.__('Automated Manual')
    'Direct Drive': req.__('Direct Drive')
  model_body: (req)->
    "Cargo Vans": "Cargo Vans"
    "Compact Cars": "Compact Cars"
    "Convertible": "Convertible"
    "Coupe": "Coupe"
    "Crossover": "Crossover"
    "Hatchback": "Hatchback"
    "Large Cars": "Large Cars"
    "Midsize Cars": "Midsize Cars"
    "Midsize Station Wagons": "Midsize Station Wagons"
    "Mini Compact Cars": "Mini Compact Cars"
    "Minivan": "Minivan"
    "Not Available": "Not Available"
    "Panel Van": "Panel Van"
    "Passenger Vans": "Passenger Vans"
    "Pickup": "Pickup"
    "Roadster": "Roadster"
    "Sedan": "Sedan"
    "Small Pickup Trucks": "Small Pickup Trucks"
    "Small Station Wagons": "Small Station Wagons"
    "Sport Utility Vehicles": "Sport Utility Vehicles"
    "Standard Pickup Trucks": "Standard Pickup Trucks"
    "Station Wagon": "Station Wagon"
    "Subcompact Cars": "Subcompact Cars"
    "SUV": "SUV"
    "Two Seaters": "Two Seaters"
    "Van": "Van"
  region: (req)->
    "Europe": "Europe"
    "Asia": "Asia"
    "USA": "USA"
  country: (req)->
    "Australia": "Australia"
    "Austria": "Austria"
    "China": "China"
    "Czech Republic": "Czech Republic"
    "Denmark": "Denmark"
    "France": "France"
    "Germany": "Germany"
    "India": "India"
    "Italy": "Italy"
    "Japan": "Japan"
    "Malaysia": "Malaysia"
    "Netherlands": "Netherlands"
    "Romania": "Romania"
    "Russia": "Russia"
    "Serbia": "Serbia"
    "South Korea": "South Korea"
    "Spain": "Spain"
    "Sweden": "Sweden"
    "Switzerland": "Switzerland"
    "Taiwan": "Taiwan"
    "UK": "UK"
    "Ukraine": "Ukraine"
    "USA": "USA"
  model_drive: (req)->
    "4WD": "4WD"
    "All Wheel Drive": "All Wheel Drive"
    "AWD": "AWD"
    "Four Wheel Drive": "Four Wheel Drive"
    "Front": "Front"
    "Front Wheel Driv": "Front Wheel Driv"
    "Not Available": "Not Available"
    "Rear": "Rear"
    "Rear Wheel Drive": "Rear Wheel Drive"
  model_engine_type: (req) ->
    "boxer": "boxer"
    "dual-disk rotary": "dual-disk rotary"
    "electric": "electric"
    "Flat": "Flat"
    "in-line": "in-line"
    "Inline": "Inline"
    "Not Available": "Not Available"
    "single": "single"
    "V": "V"
    "W": "W"
  model_engine_position: (req) ->
    "Front": "Front"
    "Middle": "Middle"
    "Rear": "Rear"
  model_engine_fuel: (req) ->
    "Biofuel": "Biofuel"
    "Diesel": "Diesel"
    "Diesel / Electric Hybrid": "Diesel / Electric Hybrid"
    "Electric": "Electric"
    "Flex Fuel": "Flex Fuel"
    "Flex-Fuel (Premium Unleaded Reco": "Flex-Fuel (Premium Unleaded Reco"
    "Flex-Fuel (Premium Unleaded/E85)": "Flex-Fuel (Premium Unleaded/E85)"
    "Flex-Fuel (Unleaded/E85)": "Flex-Fuel (Unleaded/E85)"
    "FlexFuel": "FlexFuel"
    "Gasoline": "Gasoline"
    "Gasoline - Premium": "Gasoline - Premium"
    "Gasoline / Electric Hybrid": "Gasoline / Electric Hybrid"
    "LPG": "LPG"
    "Natural Gas (CNG)": "Natural Gas (CNG)"
    "Premium": "Premium"
    "Premium Unleaded (Recommended)": "Premium Unleaded (Recommended)"
    "Premium Unleaded (Required)": "Premium Unleaded (Required)"
    "Regular Unleaded": "Regular Unleaded"


module.exports = new Static