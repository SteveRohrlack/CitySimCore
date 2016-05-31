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

### Overview

### City

The "City" is composed of a multi-layerd map (see CityMap) and
multiple statistical information.

These information include:

* **Budget:** current budget and ongoing cost
* **Ressources:** current supply and demand for ressources
* **Population:** current population count

### CityMap

The map is composed of multiple "layers", each holding information
regarding a different aspects of the map (for example: land value).

### Cell

A single address (1x1) on a layer is called a "cell".

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

Three different types of tiles exist:

* Propable
* Ploppable
* Zoneable

Each tile type needs to function slightly different.

#### Tile Type: Propable

This type of tile describes map objects that function as
more or less decorative objects.

Examples include: water, tree, rock, mountain

#### Tile Type: Ploppable

A "ploppable" is a predefined tile that can be added to the map.
Most ploppables have statistical effects (for example: a park has
a positive statistical value associated with the land value layer).
A ploppable has a cost for buying it and ongoing cost to cover it's operation.

Examples include: park, hospital, street

#### Tile Type: Zoneable

Zoneables are tiles that are filled with buildings by the simulation.

The act of filling a zoneable is called "growing".

Examples include: residential zone, commercial zone, industrial zone

#### Tile Attributes

Tiles may also adopt one or more of the following behaviours.
These behaviours are implemented using protocol composition.

* **not destructable:** tile can not be removed from map
* **must be placed near street:** tile must be adjacent to street
* **includes map statistics:** tile contains statistic information
* **can have conditions:** condition example: on fire
* **contains budget information:** one time cost and/or running cost
* **produces one ressource:** see "Ressources"
* **consumes one or more ressources:** see "Ressources"

##### example content objects with attributes

![image](https://raw.githubusercontent.com/SteveRohrlack/CitySimCore/master/docs/readme/content-objects-examples.png)

### Ressources

There will be two distinct ressources in the simulation that can be
produced and consumed.

* electricity
* water

## Event system

The following objects are emitting events by adopting the "EventEmitting"
protocol.

Each event is given a payload.

Actors (see "Actors") heavily make use of the event system.

### CityMapEvents

* Event "AddTile", payload of type "Tileable"
* Event "RemoveTile", payload of type "Tileable"

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

Actors are lightweight objects that advance the simluation state. They should,
however, not contain any state themself.

Actors are added to the simulation as needed. For example, you may not want to
add the FireActor, responsible for starting fires, right away but later on when
the player can handle such events - thus allowing a smoother learning curve for the
player.

Actors make use of the event system so they can react to certain situations.

It is planned to implement numerous actors, for example:

* **BudgetActor:** manages budget
* **ElectricityActor:** manages electricity
* **WaterActor:** manages water
* **FireActor:** manages fires
* **CrimeActor:** manages crimes
* **ZoneDevelopmentActor:** manages zone development

#### Budget

The "Budget" actor updates the currently available budget.

It subscribes to the "AddTile" and "RemoveTile" events of the CityMap.

When adding or removing a tile to/from the TileLayer that contain cost,
(are "Budgetable") they will be handled by this actor.

It runs every 10 ticks and subtracts the current total ongoing cost
from the budget and adds collected taxes to it.

#### Electricity

The "Electricity" actor manages the current state of production and
consumption of electricity.

It subscribes to the "AddTile" and "RemoveTile" events of the CityMap.

When adding or removing a tile to/from the TileLayer that produce or
consume ressources (are "RessourceProducing" or "RessourceConsuming"),
they will be handled by this actor.

## Progress

I'm currently extending the data model for non-map related statistics.
Also, the "Actor" api is beeing created and tested by implementing actors.

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
