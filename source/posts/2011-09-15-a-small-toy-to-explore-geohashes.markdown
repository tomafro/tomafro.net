---
layout: post
title: "A small toy to explore geohashes"
tags: [geohash, toy, app]
---
For an app I've been building, I've been looking into [geohashes](http://geohash.org/).  For those who don't know, the [geohash](http://en.wikipedia.org/wiki/Geohash) format is a simple way to encode latitude and longitude into a single string.  As an example, Nelson's Column in London (51.507794, -0.127952) has the geohash `gcpvj0dyds`.

Geohashes have a couple of interesting features.  First, as you remove characters, you lose precision. `gcpvj0dyds` fairly accurately points to Nelson's Column; `gcpvj0d` represents the South-West of Trafalgar Square and some of the Mall; and `gcpvj` covers most of Central London, as well as Islington and King's Cross.  A geohash doesn't really represent a point, but rather a bounding area within which a point may lie.  The longer the geohash, the smaller that bounding area.

The other interesting property geohashes have is that nearby locations usually (but not always) share similar prefixes.  So much of North London is in `gcpv`, while much of South London is in `gcpu`.  However, due to the [Prime Meridian](http://en.wikipedia.org/wiki/Prime_Meridian) passing through Greenwhich, South East London has the geohash `u10h` - wildly different than the other two.

This probably sounds a bit complicated.  I was having trouble getting my head around the concept, so to try and get to grips with geohashes I've written a toy app that draws them on a map.  To try it out, go to [http://geohash.gofreerange.com](http://geohash.gofreerange.com), click the map, zoom and play.  If you find it useful, let me know.

<div class="update">
Update: This code is now available [on github](https://github.com/tomafro/geohash-explorer).
</div>