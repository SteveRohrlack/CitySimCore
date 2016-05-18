# CitySimCore

This is sort of my personal swift playground - nothing special.

I'll be working on a simplistic city simulation. This repository is intended 
to only hold the simulation data and logic.

## Data structure

### Map

The simulation is wokring on a 2D "map". The map is to be seen as a top-down 
view of a city.

The map is composed of multiple "layers", each holding information regarding a 
different aspects of the map.

A single address on a layer is called a "cell".

A layer may contain several "tiles". A tile must cover at least one cell but 
can cover multiple cells.

### Tile

All tiles are based on "Locateable".

There are currently three different tile types:

Each tile type needs to function slightly different.

* Zoneable: may contain content
* Ploppable: name may be changed, holds statistical information
* Propable

### Layer

There are currently two different types of layers:

* TileLayer: contains tiles
* StatisticsLayer

Tile types that hold statistical value must be handled accordingly.

### StatisticLayer

A StatisticLayer contains numeric values regarding statistics for a certain 
aspect of the map. Statistical (numeric) values add up.

It is planned to implement numerous statistical layers, at least for the 
following map information:

* Air Pollution
* Noise
* Fire Hazzard
* Crime Probability
* Land Value
* etc.

By combining the numeric values of all statistical layers for a defined 
location (cell or tile), a "quality" score can be calculated and used 
throughout the simulation.

## Progress

I'm currently working on the data structure, implementing routines to 
add and remove different tiles and tile types and updating the correspding 
statistical values accordingly.

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

[![Test Coverage](https://codeclimate.com/github/SteveRohrlack/CitySimCore/badges/coverage.svg)](https://codeclimate.com/github/SteveRohrlack/CitySimCore/coverage)

[![Issue Count](https://codeclimate.com/github/SteveRohrlack/CitySimCore/badges/issue_count.svg)](https://codeclimate.com/github/SteveRohrlack/CitySimCore)
