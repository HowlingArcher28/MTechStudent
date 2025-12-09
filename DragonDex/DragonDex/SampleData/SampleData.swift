// SampleData.swift
import Foundation

enum SampleData {
    static let powers: [Power] = [
        // Fire
        Power(name: "Flame Burst", element: .fire, damage: 60, cost: 20, description: "A burst of scorching flames."),
        Power(name: "Inferno Surge", element: .fire, damage: 85, cost: 28, description: "Unleashes a roaring inferno that engulfs foes."),
        Power(name: "Cinder Dash", element: .fire, damage: 40, cost: 12, description: "A blazing sprint that sears anything in its path."),
        Power(name: "Blazing Comet", element: .fire, damage: 95, cost: 32, description: "A comet of flame crashes into the enemy."),
        Power(name: "Ashen Veil", element: .fire, damage: 0, cost: 16, description: "Veil of ash that obscures incoming attacks."),
        Power(name: "Ember Volley", element: .fire, damage: 55, cost: 18, description: "Rapid-fire embers pepper the battlefield."),
        Power(name: "Lava Surge", element: .fire, damage: 100, cost: 35, description: "Molten lava surges beneath the foe."),

        // Water
        Power(name: "Tidal Wave", element: .water, damage: 55, cost: 18, description: "A crushing wave engulfs foes."),
        Power(name: "Maelstrom Pull", element: .water, damage: 70, cost: 24, description: "Churns the sea into a vortex that drags enemies inward."),
        Power(name: "Aqua Lance", element: .water, damage: 62, cost: 20, description: "A piercing jet of water."),
        Power(name: "Mist Shroud", element: .water, damage: 0, cost: 14, description: "Blankets the field in concealing mist."),
        Power(name: "Riptide", element: .water, damage: 78, cost: 26, description: "A sudden pull that sweeps foes away."),
        Power(name: "Glacial Current", element: .water, damage: 68, cost: 22, description: "Chilling currents sap enemy strength."),

        // Earth
        Power(name: "Stone Crush", element: .earth, damage: 50, cost: 15, description: "Earth-shattering slam."),
        Power(name: "Quake Breaker", element: .earth, damage: 80, cost: 26, description: "Splits the ground with a devastating tremor."),
        Power(name: "Boulder Hurl", element: .earth, damage: 72, cost: 24, description: "A massive boulder hurled with force."),
        Power(name: "Ironbark", element: .earth, damage: 0, cost: 18, description: "Toughens scales with earthen armor."),
        Power(name: "Faultline", element: .earth, damage: 88, cost: 30, description: "Cracks the battlefield to stagger foes."),
        Power(name: "Sandstorm", element: .earth, damage: 46, cost: 14, description: "Whipping sands reduce enemy accuracy."),

        // Air
        Power(name: "Gale Slash", element: .air, damage: 45, cost: 12, description: "Razor-sharp gusts of wind."),
        Power(name: "Cyclone Cutter", element: .air, damage: 68, cost: 22, description: "A spiraling wind blade that tears through armor."),
        Power(name: "Jetstream", element: .air, damage: 58, cost: 18, description: "Accelerated winds strike with precision."),
        Power(name: "Updraft", element: .air, damage: 0, cost: 12, description: "Lift that boosts speed and evasion."),
        Power(name: "Tempest Roar", element: .air, damage: 82, cost: 28, description: "A thunderous gale knocks foes off balance."),
        Power(name: "Featherstorm", element: .air, damage: 52, cost: 16, description: "Slicing feathers buffet the enemy."),

        // Lightning
        Power(name: "Thunderclap", element: .lightning, damage: 75, cost: 25, description: "A deafening strike of lightning from above."),
        Power(name: "Arc Chain", element: .lightning, damage: 60, cost: 20, description: "Bolts that chain between multiple targets."),
        Power(name: "Volt Lance", element: .lightning, damage: 66, cost: 22, description: "A piercing spear of electricity."),
        Power(name: "Static Field", element: .lightning, damage: 0, cost: 14, description: "A crackling field that slows attackers."),
        Power(name: "Storm Surge", element: .lightning, damage: 92, cost: 32, description: "A storm’s fury condensed into a single blast."),
        Power(name: "Ionic Burst", element: .lightning, damage: 58, cost: 18, description: "A sudden discharge to stun foes."),

        // Ice
        Power(name: "Glacial Spike", element: .ice, damage: 58, cost: 18, description: "Piercing shards of ancient ice."),
        Power(name: "Permafrost", element: .ice, damage: 0, cost: 16, description: "Chills the ground to slow advances."),
        Power(name: "Hail Barrage", element: .ice, damage: 64, cost: 20, description: "A storm of hailstones pelts the target."),
        Power(name: "Frostbite", element: .ice, damage: 72, cost: 24, description: "Biting cold that saps vitality."),
        Power(name: "Crystal Shard", element: .ice, damage: 54, cost: 16, description: "Razor-edged ice crystals strike swiftly."),

        // Nature
        Power(name: "Vine Lash", element: .nature, damage: 46, cost: 14, description: "Entangling vines that strike and bind."),
        Power(name: "Bloom Guard", element: .nature, damage: 0, cost: 16, description: "Protective flora that cushions incoming blows."),
        Power(name: "Thorn Volley", element: .nature, damage: 62, cost: 20, description: "A volley of hardened thorns."),
        Power(name: "Verdant Pulse", element: .nature, damage: 58, cost: 18, description: "A wave of life energy disrupts foes."),
        Power(name: "Bramble Snare", element: .nature, damage: 40, cost: 12, description: "Roots entangle and slow the target."),

        // Shadow
        Power(name: "Umbral Step", element: .shadow, damage: 62, cost: 21, description: "Slip through shadows and strike from behind."),
        Power(name: "Nightglare", element: .shadow, damage: 70, cost: 24, description: "A chilling stare that weakens resolve."),
        Power(name: "Shade Veil", element: .shadow, damage: 0, cost: 16, description: "A cloak of darkness to evade detection."),
        Power(name: "Void Rend", element: .shadow, damage: 88, cost: 30, description: "Rends reality with abyssal force."),

        // Light
        Power(name: "Radiant Beam", element: .light, damage: 72, cost: 24, description: "A focused beam of searing light."),
        Power(name: "Sunlance", element: .light, damage: 80, cost: 26, description: "A lance of pure sunlight."),
        Power(name: "Aegis Glow", element: .light, damage: 0, cost: 16, description: "A radiant shield that wards off harm."),
        Power(name: "Dawnburst", element: .light, damage: 90, cost: 32, description: "An explosive flash that purges shadows.")
    ]

    static var powerIndex: [UUID: Power] {
        Dictionary(uniqueKeysWithValues: powers.map { ($0.id, $0) })
    }

    static let dragons: [Dragon] = {
        let p = powers
        let byElement = Dictionary(grouping: p, by: { $0.element })

        func ids(_ e: Element, _ count: Int, offset: Int = 0) -> [UUID] {
            let arr = byElement[e] ?? []
            guard !arr.isEmpty else { return [] }
            return Array(arr.dropFirst(max(0, offset)).prefix(max(0, count))).map { $0.id }
        }

        return [
            // Fire (use FireDragon asset for the flagship)
            Dragon(name: "Emberfang", element: .fire, rarity: 5,
                   description: "A legendary fire dragon with molten scales.",
                   imageName: "FireDragon",
                   stats: .init(hp: 200, attack: 90, speed: 70),
                   powerIDs: ids(.fire, 2, offset: 0)),
            Dragon(name: "Emberling", element: .fire, rarity: 2,
                   description: "A playful spark sprite with surprising bite.",
                   imageName: "flame",
                   stats: .init(hp: 140, attack: 52, speed: 68),
                   powerIDs: ids(.fire, 2, offset: 2)),
            Dragon(name: "Pyrecrest", element: .fire, rarity: 4,
                   description: "Carries a crown of ever-burning embers.",
                   imageName: "flame.circle.fill",
                   stats: .init(hp: 185, attack: 84, speed: 72),
                   powerIDs: ids(.fire, 2, offset: 3)),

            // Water (use WaterDragon asset)
            Dragon(name: "Tidewhisper", element: .water, rarity: 4,
                   description: "Graceful master of the seas.",
                   imageName: "WaterDragon",
                   stats: .init(hp: 180, attack: 70, speed: 85),
                   powerIDs: ids(.water, 2, offset: 0)),
            Dragon(name: "Maelstrom", element: .water, rarity: 5,
                   description: "A living vortex; tides bend to its will.",
                   imageName: "waveform",
                   stats: .init(hp: 200, attack: 83, speed: 80),
                   powerIDs: ids(.water, 3, offset: 1)),

            // Earth (use EarthDragon asset)
            Dragon(name: "Stonebloom", element: .earth, rarity: 3,
                   description: "Guardian of the ancient groves.",
                   imageName: "EarthDragon",
                   stats: .init(hp: 220, attack: 65, speed: 50),
                   powerIDs: ids(.earth, 2, offset: 0)),
            Dragon(name: "Quakeheart", element: .earth, rarity: 4,
                   description: "Steady as mountains, its roar shakes the land.",
                   imageName: "mountain.2.fill",
                   stats: .init(hp: 230, attack: 76, speed: 48),
                   powerIDs: ids(.earth, 3, offset: 1)),

            // Air
            Dragon(name: "Skyrazor", element: .air, rarity: 3,
                   description: "Cuts the sky with gale-forged talons.",
                   imageName: "wind",
                   stats: .init(hp: 165, attack: 62, speed: 93),
                   powerIDs: ids(.air, 2, offset: 0)),
            Dragon(name: "Tempestwing", element: .air, rarity: 5,
                   description: "Brings tempests on thunderous wings.",
                   imageName: "tornado",
                   stats: .init(hp: 185, attack: 88, speed: 98),
                   powerIDs: ids(.air, 3, offset: 1)),

            // Lightning
            Dragon(name: "Stormclaw", element: .lightning, rarity: 5,
                   description: "Crackles with untamed thunder, swift as a stormfront.",
                   imageName: "bolt.fill",
                   stats: .init(hp: 190, attack: 95, speed: 92),
                   powerIDs: ids(.lightning, 2, offset: 0)),
            Dragon(name: "Thundermaw", element: .lightning, rarity: 4,
                   description: "Its roar heralds storms over the horizon.",
                   imageName: "bolt.circle.fill",
                   stats: .init(hp: 185, attack: 88, speed: 86),
                   powerIDs: ids(.lightning, 2, offset: 2)),

            // Ice (use IceDragon asset)
            Dragon(name: "Frostwing", element: .ice, rarity: 4,
                   description: "Wings trail snowflakes, breath freezes the air.",
                   imageName: "IceDragon",
                   stats: .init(hp: 175, attack: 72, speed: 78),
                   powerIDs: ids(.ice, 2, offset: 0)),
            Dragon(name: "Glacierheart", element: .ice, rarity: 5,
                   description: "A titan of frost, slow to anger, impossible to stop.",
                   imageName: "snowflake.circle.fill",
                   stats: .init(hp: 220, attack: 88, speed: 60),
                   powerIDs: ids(.ice, 3, offset: 1)),

            // Nature (use PlantDragon asset)
            Dragon(name: "Verdantscale", element: .nature, rarity: 4,
                   description: "Life blossoms in its wake; forests heed its call.",
                   imageName: "PlantDragon",
                   stats: .init(hp: 205, attack: 68, speed: 60),
                   powerIDs: ids(.nature, 2, offset: 0)),
            Dragon(name: "Gladekeeper", element: .nature, rarity: 3,
                   description: "Tender of sacred groves, stern to intruders.",
                   imageName: "leaf.fill",
                   stats: .init(hp: 200, attack: 60, speed: 55),
                   powerIDs: ids(.nature, 2, offset: 1)),

            // Shadow
            Dragon(name: "Nightshroud", element: .shadow, rarity: 5,
                   description: "A silhouette against the moon, striking from darkness.",
                   imageName: "moon.stars.fill",
                   stats: .init(hp: 185, attack: 88, speed: 90),
                   powerIDs: ids(.shadow, 2, offset: 0)),

            // Light
            Dragon(name: "Dawnflare", element: .light, rarity: 5,
                   description: "Radiates a warm glow that banishes gloom.",
                   imageName: "sun.max.fill",
                   stats: .init(hp: 195, attack: 91, speed: 82),
                   powerIDs: ids(.light, 2, offset: 0)),
            Dragon(name: "Aurorascale", element: .light, rarity: 4,
                   description: "Shimmers with the colors of dawn and dusk.",
                   imageName: "sunrise.fill",
                   stats: .init(hp: 180, attack: 74, speed: 77),
                   powerIDs: ids(.light, 2, offset: 1)),

            // New: Space-themed (use SpaceDragon asset)
            Dragon(name: "Starborne", element: .light, rarity: 5,
                   description: "Celestial scales gleam with starlight.",
                   imageName: "SpaceDragon",
                   stats: .init(hp: 205, attack: 92, speed: 88),
                   powerIDs: ids(.light, 2, offset: 0)),

            // New: Toxic-themed (use ToxicDragon asset; nature fits best)
            Dragon(name: "Toxiscale", element: .nature, rarity: 4,
                   description: "Venomous thorns and a poisonous glare.",
                   imageName: "ToxicDragon",
                   stats: .init(hp: 190, attack: 80, speed: 62),
                   powerIDs: ids(.nature, 2, offset: 2)),

            // Water variant using WaterDragon asset as well
            Dragon(name: "Rivertide", element: .water, rarity: 3,
                   description: "Swift currents answer its call.",
                   imageName: "WaterDragon",
                   stats: .init(hp: 170, attack: 66, speed: 74),
                   powerIDs: ids(.water, 2, offset: 2))
        ]
    }()
}

