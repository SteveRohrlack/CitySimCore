This is sort of my personal swift playground - nothing special.

# CitySimCore

I'll be working on a simplistic city simulation. This repository
is intended to represent only the simulation data and logic, no UI.

The simulation works on a 2D representation of a city.

## Data structure

The following describes the current state of the data structure
the simulation will use.

This section is also meant to elaborate on and describe
specific terms related to the data structure.

### Map

The "city" is represented as a 2D "map". The map is to be seen as a
top-down view of a city.

The map is composed of multiple "layers", each holding information
regarding a different aspects of the map (for example: land value).

A single address on a layer is called a "cell".

### Layer

There are currently two different types of layers:

* TileLayer: contains "tiles"
* StatisticsLayer: contains statistic information

#### Tile Layer

This layer may contain several "tiles".

#### Statistic Layer

A StatisticLayer contains numeric values regarding statistics for
a certain aspect of the map.

Statistical values are numeric.

If statistical values overlap, they add up.

It is planned to implement numerous statistical layers, for example:

* Air Pollution
* Noise
* Fire Hazzard
* Crime Probability
* Land Value
* etc.

### Tile

A tile must cover at least one cell.
If a tile covers multiple cells, each cell holds a corresponding
tile object.

All tiles are based on a protocol called "Locateable". It contains
properties and functions that allow an object to be located on
a layer.

There are currently three different types of tiles:

* Propable
* Ploppable
* Zoneable

Each tile type needs to function slightly different.

Tiles may also adopt one or more of the following behaviours.
These behaviours are implemented using protocol composition.

* not destructable: tile can not be removed from map
* must be placed near street: tile must be adjacent to street
* includes map statistics: tile contains statistic information
* can have conditions: condition example: on fire

#### Propable

This type of tile describes map objects that function as
more or less decorative objects.

Examples include: water, tree, rock, mountain

#### Ploppable

A "ploppable" is a predefined tile that can be added to the map.
Most ploppables have statistical effects (for example: a park has
a positive statistical value associated with the land value layer).
A ploppable hast a cost for buying it and 
ongoing cost to cover it's operation.

Examples include: park, hospital, street

#### Zoneable

Zoneables are tiles that are filled with buildings by the simulation.

The act of filling a zoneable is called "growing".

Examples include: residential zone, commercial zone, industrial zone

## Simulation

### Timeframe

The simulation is advanced in defined time intervals.
Such an interval is called "tick".



### Statistic map data

By combining the numeric values of all statistical layers for
a defined location (cell or tile), a "quality" score can be
calculated and used throughout the simulation.

This allows, for example, to choose fitting locations for
"growing" buildings in zoneables.

### Actors

Actors are objects that handle simluation state and actually advance
the simulation.

They are run periodically but at most once per tick.

For example: The "budget" actor contains the currently available budget.
It runs every 10 ticks and subtracts the ongoing cost of active ploppables
from - and adds collected taxes to the available budget.

It is planned to implement numerous actors, for example:

* BudgetActor
* FireActor
* CrimeActor
* ZoneDevelopmentActor
* etc.

## Progress

I'm currently working on the map layers and data structure,
implementing routines to add and remove different tiles
and tile types and updating the correspding statistical values.

The next task at hand is the creation all

## setup

    bundle install

## Docs

Docs are generated using jazzy. To update, run:

    bundle exec "jazzy"

## QA

### Travis

[![Build Status](https://travis-ci.org/SteveRohrlack/CitySimCore.svg?branch=master)](https://travis-ci.org/SteveRohrlack/CitySimCore)

### CodeClimate

[![Code Climate](https://codeclimate.com/github/SteveRohrlack/CitySimCore/badges/gpa.svg)](https://codeclimate.com/github/SteveRohrlack/CitySimCore)

[![Issue Count](https://codeclimate.com/github/SteveRohrlack/CitySimCore/badges/issue_count.svg)](https://codeclimate.com/github/SteveRohrlack/CitySimCore)
