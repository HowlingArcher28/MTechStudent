import SwiftUI

struct ContentView: View {

    // Made internal so scene files can reference ContentView.Scene
    enum Scene {
        case start

        // Main routes
        case house
        case woods
        case graveyard
        case town

        // House branch (original)
        case attic
        case basement
        case atticWindow
        case atticJournal
        case basementHiddenDoor
        case basementWell

        // Deeper House (existing)
        case rooftop
        case mirrorDouble
        case hiddenPage
        case catacombs
        case altar
        case submerged

        // House horror chain (10 layers)
        case hiddenCorridor       // 1
        case nursery              // 2
        case musicBox             // 3
        case portraitGallery      // 4
        case redDoor              // 5
        case whisperStair         // 6
        case lockedStudy          // 7
        case ashParlor            // 8
        case finalRitual          // 9
        case heartOfHouse         // 10

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
        case lanternRow          // 1
        case maskAlley           // 2
        case whisperMarket       // 3
        case clockStairs         // 4
        case bellFoundry         // 5
        case rooftopWires        // 6
        case backstageDoor       // 7
        case velvetBalcony       // 8
        case midnightParade      // 9
        case townHeart           // 10

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

        // New endings
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

            // Ambient overlays (both are used to add atmosphere)
            FogOverlay().allowsHitTesting(false)
            FirefliesOverlay().allowsHitTesting(false)

            Group {
                switch scene {
                case .start:
                    StartScreen { picked in scene = picked }

                // MARK: House (routed to separate files)
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

                // MARK: Woods (routed to separate files)
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

                // Woods deep chain routing
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

                // MARK: Graveyard (routed to separate files)
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

                // Graveyard deep chain routing
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

                // MARK: Town (routed to separate files)
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

                // Town deep chain routing
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

                // MARK: Endings (stay inline; can be split later)
                case .endingMemory:
                    SceneView(
                        title: "Ending: Remembered",
                        description: "You belong to this night, and it belongs to you. The house hums your name.",
                        systemImage: "bookmark.circle.fill",
                        gradient: [Color.orange, Color.pink],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "New paths wait with the lights on.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.orange, Color.pink],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingPact:
                    SceneView(
                        title: "Ending: The Pact",
                        description: "You keep your promise. The house keeps a little more.",
                        systemImage: "seal.fill",
                        gradient: [Color.orange, Color.brown],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Bargains prefer repetition.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.orange, Color.brown],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingDrowned:
                    SceneView(
                        title: "Ending: Below",
                        description: "The doorway opens under the world. You swim where maps cannot follow.",
                        systemImage: "drop.triangle.fill",
                        gradient: [Color.blue, Color.cyan],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Come up for air.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.blue, Color.cyan],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingWander:
                    SceneView(
                        title: "Ending: Wanderer",
                        description: "Between stones and stars, you walk a path only you can see.",
                        systemImage: "figure.walk.motion",
                        gradient: [Color.purple, Color.mint],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Another road is already unfolding.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.purple, Color.mint],
                                foreground: .black,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingBlessing:
                    SceneView(
                        title: "Ending: Blessed",
                        description: "Warmth in your chest, light at your back. The night is kind, for now.",
                        systemImage: "sun.max.fill",
                        gradient: [Color.mint, Color.green],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "The lights will be waiting.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.mint, Color.green],
                                foreground: .black,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingBound:
                    SceneView(
                        title: "Ending: Bound",
                        description: "The ring’s heartbeat is your own. You never feel alone again.",
                        systemImage: "circle.hexagonpath.fill",
                        gradient: [Color.gray, Color.red],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "If it lets you.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.gray, Color.red],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingReunion:
                    SceneView(
                        title: "Ending: Reunion",
                        description: "A familiar hand in yours. You walk together out of the page.",
                        systemImage: "heart.circle.fill",
                        gradient: [Color.orange, Color.gray],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "They will be waiting.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.orange, Color.gray],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingRest:
                    SceneView(
                        title: "Ending: Rest",
                        description: "You sleep, and wake to gentle light. The night kept watch at your door.",
                        systemImage: "bed.double.fill",
                        gradient: [Color.cyan, Color.purple],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Another story begins.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.cyan, Color.purple],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingApplause:
                    SceneView(
                        title: "Ending: Applause",
                        description: "You bow. They cheer. The song lingers like a promise you’re happy to keep.",
                        systemImage: "music.mic",
                        gradient: [Color.blue, Color.purple],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Encore.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.blue, Color.purple],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingProtected:
                    SceneView(
                        title: "Ending: Protected",
                        description: "The charm glows softly. The dark keeps its distance, counting.",
                        systemImage: "shield.fill",
                        gradient: [Color.teal, Color.cyan],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Walk another road.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.teal, Color.cyan],
                                foreground: .black,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingConsumed:
                    SceneView(
                        title: "Ending: Consumed",
                        description: "The candles cough out. The dark pours in. The house finally eats.",
                        systemImage: "smoke.fill",
                        gradient: [Color.red, Color.orange],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "There’s always more to devour.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.red, Color.orange],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingEscapeDawn:
                    SceneView(
                        title: "Ending: Escape at Dawn",
                        description: "You reach the knife-edge of morning. The house hisses and lets you go—for now.",
                        systemImage: "sunrise.fill",
                        gradient: [Color.yellow, Color.orange],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Nightfall comes quickly here.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.yellow, Color.orange],
                                foreground: .black,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingLostTime:
                    SceneView(
                        title: "Ending: Lost Time",
                        description: "The house forgets you. Years fall off the clock like ash. You smile and do not know why.",
                        systemImage: "clock.arrow.2.circlepath",
                        gradient: [Color.gray, Color.orange],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Find yourself again.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.gray, Color.orange],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                case .endingPossessed:
                    SceneView(
                        title: "Ending: Possessed",
                        description: "You blink from the other side of the glass. Your reflection walks away in your body.",
                        systemImage: "rectangle.portrait",
                        gradient: [Color.pink, Color.orange],
                        onBack: { scene = .start },
                        choices: [
                            SceneChoice(
                                title: "Play Again",
                                subtitle: "Find a way back through.",
                                systemImage: "arrow.counterclockwise.circle.fill",
                                colors: [Color.pink, Color.orange],
                                foreground: .white,
                                action: { scene = .start }
                            )
                        ]
                    )
                }
            }
        }
    }
}

// MARK: - Start Screen

private struct StartScreen: View {
    var pick: (ContentView.Scene) -> Void
    @State private var glow = false
    @State private var showContent = false

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)
            // Title
            VStack(spacing: 2) {
                Text("Halloween Night")
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.orange, Color.yellow, Color.pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color.orange.opacity(0.9), radius: 22, x: 0, y: 8)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial.opacity(0.25), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .scaleEffect(showContent ? 1 : 0.96)
                    .animation(.spring(response: 0.6, dampingFraction: 0.9), value: showContent)
                Text("A Choose Your Own Adventure")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 1)
            }
            .padding(.top, 8)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 12)
            .animation(.easeOut(duration: 0.6).delay(0.05), value: showContent)

            // Animated hero icon
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [Color.orange.opacity(0.4), Color.clear]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        )
                    )
                    .frame(width: 127, height: 127)
                    .blur(radius: glow ? 7 : 2)
                    .scaleEffect(glow ? 1.06 : 1)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: glow)
                Circle()
                    .strokeBorder(Color.orange.opacity(0.5), lineWidth: 3)
                    .frame(width: 99, height: 99)
                    .blur(radius: 0.7)
                    .shadow(color: .orange.opacity(0.55), radius: 7, x: 0, y: 4)
                    .opacity(showContent ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.1), value: showContent)
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 54, weight: .black))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.yellow, Color.orange, Color.white.opacity(0.9)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .orange.opacity(0.8), radius: 18, x: 0, y: 9)
                    .rotationEffect(.degrees(glow ? 2 : -2))
                    .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: glow)
            }
            .padding(.top, 6)
            .onAppear {
                glow = true
                withAnimation(.spring(response: 0.7, dampingFraction: 0.85, blendDuration: 0.2)) {
                    showContent = true
                }
            }
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 14)

            // Intro text
            Text("You stand before a house that remembers you. The wind tastes like your name. The key is already in the door.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.white.opacity(0.95))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 340)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                .padding(.vertical, 6)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 16)
                .animation(.easeOut(duration: 0.55).delay(0.1), value: showContent)

            // Choices
            VStack(spacing: 14) {
                FancyChoiceButton(
                    title: "Enter the House",
                    subtitle: "The key turns itself.",
                    systemImage: "door.left.hand.open",
                    colors: [Color.orange, Color(red: 1.0, green: 0.61, blue: 0.17)],
                    foreground: .black
                ) { pick(ContentView.Scene.house) }

                FancyChoiceButton(
                    title: "Walk Into the Woods",
                    subtitle: "The path curves like a smile.",
                    systemImage: "tree.fill",
                    colors: [Color.purple.opacity(0.98), Color.indigo.opacity(0.96)],
                    foreground: .white
                ) { pick(ContentView.Scene.woods) }

                FancyChoiceButton(
                    title: "Check the Graveyard",
                    subtitle: "The names are patient.",
                    systemImage: "cross.vial",
                    colors: [Color.gray.opacity(0.92), Color.indigo],
                    foreground: .white
                ) { pick(ContentView.Scene.graveyard) }

                FancyChoiceButton(
                    title: "Return to Town",
                    subtitle: "Windows brighten when you pass.",
                    systemImage: "building.2.fill",
                    colors: [Color.cyan.opacity(0.97), Color.blue.opacity(0.93)],
                    foreground: .white
                ) { pick(ContentView.Scene.town) }
            }
            .frame(maxWidth: 380)
            .padding(.top, 8)
            .padding(.horizontal, 2)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 18)
            .animation(.easeOut(duration: 0.6).delay(0.15), value: showContent)

            Text("Choose carefully. The house is listening.")
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundColor(Color.white.opacity(0.75))
                .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 1)
                .padding(.top, 6)
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.6).delay(0.2), value: showContent)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
