import SwiftUI

struct ContentView: View {

    enum Scene {
        case start

        // Main routes
        case house
        case woods
        case graveyard
        case town

        // House branch
        case attic
        case basement
        case atticWindow
        case atticJournal
        case basementHiddenDoor
        case basementWell

        // Deeper House
        case rooftop
        case mirrorDouble
        case hiddenPage
        case catacombs
        case altar
        case submerged

        // House  chain (10 layers)
        case hiddenCorridor
        case nursery
        case musicBox
        case portraitGallery
        case redDoor
        case whisperStair
        case lockedStudy
        case ashParlor
        case finalRitual
        case heartOfHouse

        // Woods branch
        case clearing
        case cabin
        case standingStones
        case willOWisp
        case pantry
        case cabinLetter

        // Deeper Woods
        case portal
        case hiddenPath
        case fairyGlen
        case hearth
        case recipe

        // Woods 10-step deep chain
        case glimmerTrail
        case thornArch
        case hollowLog
        case lanternMoth
        case riverCrossing
        case elderOak
        case mossStairs
        case moonBridge
        case glenThrone
        case forestHeart

        // Graveyard branch
        case crypt
        case mausoleum
        case secretPassage
        case prayerCandle
        case ringCurse
        case hiddenNiche

        // Deeper Graveyard
        case spirit
        case locket
        case catacombLibrary

        // Graveyard 10-step deep chain
        case boneGate
        case ossuaryHall
        case midnightBell
        case shadowProcession
        case oathStone
        case veiledPriest
        case bloodLantern
        case finalVigil
        case graveHeart

        // Town branch
        case inn
        case square
        case rentedRoom
        case bardTale
        case fountain
        case vendor

        // Deeper Town
        case dream
        case audience
        case charmUse

        // Town 10-step deep chain
        case lanternRow
        case maskAlley
        case whisperMarket
        case clockStairs
        case bellFoundry
        case rooftopWires
        case backstageDoor
        case velvetBalcony
        case midnightParade
        case townHeart

        // Endings 
        case endingMemory
        case endingPact
        case endingDrowned
        case endingWander
        case endingBlessing
        case endingBound
        case endingReunion
        case endingRest
        case endingApplause
        case endingProtected
        case endingConsumed
        case endingEscapeDawn
        case endingLostTime
        case endingPossessed
    }

    @State private var scene: Scene = .start

    private var halloweenBackground: some View {
        RadialGradient(
            gradient: Gradient(colors: [
                Color(red: 0.18, green: 0.03, blue: 0.22),
                Color(red: 0.06, green: 0.01, blue: 0.10),
                Color(red: 0.02, green: 0.01, blue: 0.06)
            ]),
            center: .center,
            startRadius: 10,
            endRadius: 650
        )
        .ignoresSafeArea()
    }

    var body: some View {
        ZStack {
            halloweenBackground

            FogOverlay().allowsHitTesting(false)
            FirefliesOverlay().allowsHitTesting(false)

            Group {
                switch scene {
                case .start:
                    StartScreen { picked in scene = picked }

                // MARK: House
                case .house:
                    HouseScene(setScene: { scene = $0 }, onBack: { scene = .start })
                case .attic:
                    AtticScene(setScene: { scene = $0 }, onBack: { scene = .house })
                case .atticWindow:
                    AtticWindowScene(setScene: { scene = $0 }, onBack: { scene = .attic })
                case .mirrorDouble:
                    MirrorDoubleScene(setScene: { scene = $0 }, onBack: { scene = .atticWindow })
                case .rooftop:
                    RooftopScene(setScene: { scene = $0 }, onBack: { scene = .atticWindow })
                case .atticJournal:
                    AtticJournalScene(setScene: { scene = $0 }, onBack: { scene = .attic })
                case .hiddenPage:
                    HiddenPageScene(setScene: { scene = $0 }, onBack: { scene = .atticJournal })
                case .hiddenCorridor:
                    HiddenCorridorScene(setScene: { scene = $0 }, onBack: { scene = .attic })
                case .nursery:
                    NurseryScene(setScene: { scene = $0 }, onBack: { scene = .hiddenCorridor })
                case .musicBox:
                    MusicBoxScene(setScene: { scene = $0 }, onBack: { scene = .nursery })
                case .portraitGallery:
                    PortraitGalleryScene(setScene: { scene = $0 }, onBack: { scene = .musicBox })
                case .redDoor:
                    RedDoorScene(setScene: { scene = $0 }, onBack: { scene = .portraitGallery })
                case .whisperStair:
                    WhisperStairScene(setScene: { scene = $0 }, onBack: { scene = .redDoor })
                case .lockedStudy:
                    LockedStudyScene(setScene: { scene = $0 }, onBack: { scene = .whisperStair })
                case .ashParlor:
                    AshParlorScene(setScene: { scene = $0 }, onBack: { scene = .lockedStudy })
                case .finalRitual:
                    FinalRitualScene(setScene: { scene = $0 }, onBack: { scene = .ashParlor })
                case .heartOfHouse:
                    HeartOfHouseScene(setScene: { scene = $0 }, onBack: { scene = .finalRitual })
                case .basement:
                    BasementScene(setScene: { scene = $0 }, onBack: { scene = .house })
                case .basementHiddenDoor:
                    BasementHiddenDoorScene(setScene: { scene = $0 }, onBack: { scene = .basement })
                case .catacombs:
                    CatacombsScene(setScene: { scene = $0 }, onBack: { scene = .basementHiddenDoor })
                case .altar:
                    AltarScene(setScene: { scene = $0 }, onBack: { scene = .catacombs })
                case .catacombLibrary:
                    CatacombLibraryScene(setScene: { scene = $0 }, onBack: { scene = .catacombs })
                case .basementWell:
                    BasementWellScene(setScene: { scene = $0 }, onBack: { scene = .basement })
                case .submerged:
                    SubmergedScene(setScene: { scene = $0 }, onBack: { scene = .basementWell })

                // MARK: Woods
                case .woods:
                    WoodsScene(setScene: { scene = $0 }, onBack: { scene = .start })
                case .clearing:
                    ClearingScene(setScene: { scene = $0 }, onBack: { scene = .woods })
                case .standingStones:
                    StandingStonesScene(setScene: { scene = $0 }, onBack: { scene = .clearing })
                case .portal:
                    PortalScene(setScene: { scene = $0 }, onBack: { scene = .standingStones })
                case .willOWisp:
                    WillOWispScene(setScene: { scene = $0 }, onBack: { scene = .clearing })
                case .hiddenPath:
                    HiddenPathScene(setScene: { scene = $0 }, onBack: { scene = .willOWisp })
                case .fairyGlen:
                    FairyGlenScene(setScene: { scene = $0 }, onBack: { scene = .hiddenPath })
                case .cabin:
                    CabinScene(setScene: { scene = $0 }, onBack: { scene = .woods })
                case .hearth:
                    HearthScene(setScene: { scene = $0 }, onBack: { scene = .cabin })
                case .recipe:
                    RecipeScene(setScene: { scene = $0 }, onBack: { scene = .hearth })
                case .pantry:
                    PantryScene(setScene: { scene = $0 }, onBack: { scene = .cabin })
                case .cabinLetter:
                    CabinLetterScene(setScene: { scene = $0 }, onBack: { scene = .cabin })

                // Woods deep chain
                case .glimmerTrail:
                    GlimmerTrailScene(setScene: { scene = $0 }, onBack: { scene = .clearing })
                case .thornArch:
                    ThornArchScene(setScene: { scene = $0 }, onBack: { scene = .glimmerTrail })
                case .hollowLog:
                    HollowLogScene(setScene: { scene = $0 }, onBack: { scene = .thornArch })
                case .lanternMoth:
                    LanternMothScene(setScene: { scene = $0 }, onBack: { scene = .hollowLog })
                case .riverCrossing:
                    RiverCrossingScene(setScene: { scene = $0 }, onBack: { scene = .lanternMoth })
                case .elderOak:
                    ElderOakScene(setScene: { scene = $0 }, onBack: { scene = .riverCrossing })
                case .mossStairs:
                    MossStairsScene(setScene: { scene = $0 }, onBack: { scene = .elderOak })
                case .moonBridge:
                    MoonBridgeScene(setScene: { scene = $0 }, onBack: { scene = .mossStairs })
                case .glenThrone:
                    GlenThroneScene(setScene: { scene = $0 }, onBack: { scene = .moonBridge })
                case .forestHeart:
                    ForestHeartScene(setScene: { scene = $0 }, onBack: { scene = .glenThrone })

                // MARK: Graveyard
                case .graveyard:
                    GraveyardScene(setScene: { scene = $0 }, onBack: { scene = .start })
                case .crypt:
                    CryptScene(setScene: { scene = $0 }, onBack: { scene = .graveyard })
                case .secretPassage:
                    SecretPassageScene(setScene: { scene = $0 }, onBack: { scene = .crypt })
                case .prayerCandle:
                    PrayerCandleScene(setScene: { scene = $0 }, onBack: { scene = .crypt })
                case .spirit:
                    SpiritScene(setScene: { scene = $0 }, onBack: { scene = .prayerCandle })
                case .mausoleum:
                    MausoleumScene(setScene: { scene = $0 }, onBack: { scene = .graveyard })
                case .ringCurse:
                    RingCurseScene(setScene: { scene = $0 }, onBack: { scene = .mausoleum })
                case .hiddenNiche:
                    HiddenNicheScene(setScene: { scene = $0 }, onBack: { scene = .mausoleum })
                case .locket:
                    LocketScene(setScene: { scene = $0 }, onBack: { scene = .hiddenNiche })

                // Graveyard deep chain
                case .boneGate:
                    BoneGateScene(setScene: { scene = $0 }, onBack: { scene = .crypt })
                case .ossuaryHall:
                    OssuaryHallScene(setScene: { scene = $0 }, onBack: { scene = .boneGate })
                case .midnightBell:
                    MidnightBellScene(setScene: { scene = $0 }, onBack: { scene = .ossuaryHall })
                case .shadowProcession:
                    ShadowProcessionScene(setScene: { scene = $0 }, onBack: { scene = .midnightBell })
                case .oathStone:
                    OathStoneScene(setScene: { scene = $0 }, onBack: { scene = .shadowProcession })
                case .veiledPriest:
                    VeiledPriestScene(setScene: { scene = $0 }, onBack: { scene = .oathStone })
                case .bloodLantern:
                    BloodLanternScene(setScene: { scene = $0 }, onBack: { scene = .veiledPriest })
                case .finalVigil:
                    FinalVigilScene(setScene: { scene = $0 }, onBack: { scene = .bloodLantern })
                case .graveHeart:
                    GraveHeartScene(setScene: { scene = $0 }, onBack: { scene = .finalVigil })

                // MARK: Town
                case .town:
                    TownScene(setScene: { scene = $0 }, onBack: { scene = .start })
                case .inn:
                    InnScene(setScene: { scene = $0 }, onBack: { scene = .town })
                case .rentedRoom:
                    RentedRoomScene(setScene: { scene = $0 }, onBack: { scene = .inn })
                case .bardTale:
                    BardTaleScene(setScene: { scene = $0 }, onBack: { scene = .inn })
                case .dream:
                    DreamScene(setScene: { scene = $0 }, onBack: { scene = .rentedRoom })
                case .audience:
                    AudienceScene(setScene: { scene = $0 }, onBack: { scene = .bardTale })
                case .square:
                    SquareScene(setScene: { scene = $0 }, onBack: { scene = .town })
                case .fountain:
                    FountainScene(setScene: { scene = $0 }, onBack: { scene = .square })
                case .vendor:
                    VendorScene(setScene: { scene = $0 }, onBack: { scene = .square })
                case .charmUse:
                    CharmUseScene(setScene: { scene = $0 }, onBack: { scene = .vendor })

                // Town deep chain
                case .lanternRow:
                    LanternRowScene(setScene: { scene = $0 }, onBack: { scene = .square })
                case .maskAlley:
                    MaskAlleyScene(setScene: { scene = $0 }, onBack: { scene = .lanternRow })
                case .whisperMarket:
                    WhisperMarketScene(setScene: { scene = $0 }, onBack: { scene = .maskAlley })
                case .clockStairs:
                    ClockStairsScene(setScene: { scene = $0 }, onBack: { scene = .whisperMarket })
                case .bellFoundry:
                    BellFoundryScene(setScene: { scene = $0 }, onBack: { scene = .clockStairs })
                case .rooftopWires:
                    RooftopWiresScene(setScene: { scene = $0 }, onBack: { scene = .bellFoundry })
                case .backstageDoor:
                    BackstageDoorScene(setScene: { scene = $0 }, onBack: { scene = .rooftopWires })
                case .velvetBalcony:
                    VelvetBalconyScene(setScene: { scene = $0 }, onBack: { scene = .backstageDoor })
                case .midnightParade:
                    MidnightParadeScene(setScene: { scene = $0 }, onBack: { scene = .velvetBalcony })
                case .townHeart:
                    TownHeartScene(setScene: { scene = $0 }, onBack: { scene = .midnightParade })

                // MARK: Endings 
                case .endingMemory:
                    EndingMemoryView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingPact:
                    EndingPactView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingDrowned:
                    EndingDrownedView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingWander:
                    EndingWanderView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingBlessing:
                    EndingBlessingView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingBound:
                    EndingBoundView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingReunion:
                    EndingReunionView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingRest:
                    EndingRestView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingApplause:
                    EndingApplauseView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingProtected:
                    EndingProtectedView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingConsumed:
                    EndingConsumedView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingEscapeDawn:
                    EndingEscapeDawnView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingLostTime:
                    EndingLostTimeView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                case .endingPossessed:
                    EndingPossessedView(onBack: { scene = .start }, onPlayAgain: { scene = .start })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
