# SonaattiMenu
Parse Sonaatti restaurant menus from RSS feed.

## Installation

Use `stack` to install the packages and build the library.
(https://github.com/commercialhaskell/stack)

## Usage

Set Overloaded strings: `*Main λ: :set -XOverloadedStrings`.

Find One menu. (returns Maybe (Text,Text)):
```
*Main λ: findMenu "piato"
Just ("Piato","Sinappisilakoita #G #L #VH (2,60\8364 / 8,00\8364), Chili con carnea #G #L #M #VH (2,60\8364 / 8,00\8364), Broileri-juureskeittoa #G #L #VH (2,60\8364 / 8,00\8364), Feta-pinaattipihvej\228 #VL (2,60\8364 / 8,00\8364), Paistopiste: Porsaan ribbsej\228 #G #L #M (4,95\8364/10,00\8364), Mustikka-jogurtti-pannacottaa #G #L (1,00\8364)")
```

Find multiple menus. (returns [(Text,Text)]):
```
*Main λ: findMenus ["piato", "wilhelmiina"]
[("Piato","Sinappisilakoita #G #L #VH (2,60\8364 / 8,00\8364), Chili con carnea #G #L #M #VH (2,60\8364 / 8,00\8364), Broileri-juureskeittoa #G #L #VH (2,60\8364 / 8,00\8364), Feta-pinaattipihvej\228 #VL (2,60\8364 / 8,00\8364), Paistopiste: Porsaan ribbsej\228 #G #L #M (4,95\8364/10,00\8364), Mustikka-jogurtti-pannacottaa #G #L (1,00\8364)"),("Wilhelmiina","Tandoori-broileriwrap #L (2,60\8364 / 5,70\8364), Jauheliha-chilikastiketta #VH#L#M (2,60\8364 / 5,70\8364), Bataatti-kookoskermacurrya #G#L#M#Veg (2,60\8364 / 5,70\8364), Lihakeittoa #VH#G#L#M (2,60\8364 / 5,70\8364), Vohveli (1,00\8364)Perjantaina 18.9 Wilhelmiinassa Tuunataan tortilloja klo 12-14 v\228lisen\228 aikana. Tervetuloa tutustumaan!")]
```
