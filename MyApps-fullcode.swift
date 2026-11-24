// ============================================================
// File: MyApps/MyAppsApp.swift
// ============================================================
//
//  MyAppsApp.swift
//  MyApps
//
//

import SwiftUI

@main
struct MyAppsApp: App {
    @State private var showMainView = false
    @State private var openingCharacter = Character()

    init() {
        LocalDataStore.shared.resetProgress()
    }

    var body: some Scene {
        WindowGroup {
            if showMainView {
                HomeView(initialCharacter: openingCharacter)
            } else {
                CharacterView(initialCharacter: openingCharacter) { selectedCharacter in
                    openingCharacter = selectedCharacter
                    showMainView = true
                }
            }
        }
    }
}

// ============================================================
// File: MyApps/Models/AppProgress.swift
// ============================================================
//
//  AppProgress.swift
//  MyApps
//

import Foundation

struct AppProgress: Codable {
    var character: Character
    var trophyCount: Int
    var awardedQuestionSetNames: [String]
    var currentQuestionSetIndex: Int
    var completedQuestionSetNames: [String]
    var completedQuestions: [CompletedQuestionRecord]
    var incorrectQuestions: [IncorrectQuestionRecord]
    var purchasedItemNames: [String]
    var equippedItemNames: [String]

    static let empty = AppProgress(
        character: Character(),
        trophyCount: 0,
        awardedQuestionSetNames: [],
        currentQuestionSetIndex: 0,
        completedQuestionSetNames: [],
        completedQuestions: [],
        incorrectQuestions: [],
        purchasedItemNames: [],
        equippedItemNames: []
    )
}

// ============================================================
// File: MyApps/Models/Character.swift
// ============================================================
//
//  Character.swift
//  MyApps
//

import Foundation

struct Character: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var skinTone: String = "Medium"
    var eyeColor: String = "Brown"
    var hairstyle: String = "Short"
    var hairColor: String = "Brown"
    var outfit: String = "Casual"
    var accessories: String = "None"
}

// ============================================================
// File: MyApps/Models/History.swift
// ============================================================
//
//  History.swift
//  MyApps
//

import Foundation

struct CompletedQuestionRecord: Identifiable, Codable {
    var id = UUID()
    let questionText: String
    let selectedAnswer: String
    let correctAnswer: String
    let questionSetName: String
    let subject: Subject
    let completedDate: Date
}

struct IncorrectQuestionRecord: Identifiable, Codable {
    var id = UUID()
    let questionText: String
    let incorrectAnswer: String
    let correctAnswer: String
    let questionSetName: String
    let subject: Subject
    let explanation: String
    let answeredDate: Date
}

// ============================================================
// File: MyApps/Models/LocalDataStore.swift
// ============================================================
//
//  LocalDataStore.swift
//  MyApps
//

import Foundation

final class LocalDataStore {
    static let shared = LocalDataStore()

    private let defaults: UserDefaults
    private let progressKey = "MyApps.savedAppProgress"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func loadProgress() -> AppProgress {
        guard let data = defaults.data(forKey: progressKey) else {
            return .empty
        }

        do {
            return try JSONDecoder().decode(AppProgress.self, from: data)
        } catch {
            return .empty
        }
    }

    func saveProgress(_ progress: AppProgress) {
        do {
            let data = try JSONEncoder().encode(progress)
            defaults.set(data, forKey: progressKey)
        } catch {
            print("Unable to save app progress: \(error.localizedDescription)")
        }
    }

    func resetProgress() {
        defaults.removeObject(forKey: progressKey)
    }
}

// ============================================================
// File: MyApps/Models/Question.swift
// ============================================================
//
//  Question.swift
//  MyApps
//

import Foundation

enum Subject: String, CaseIterable, Identifiable, Codable {
    case mathematics = "Mathematics"
    case science = "Science"
    case history = "History"
    case french = "French"

    var id: String {
        rawValue
    }
}

struct Question: Identifiable {
    let id: UUID = UUID()
    let questionText: String
    let answerOptions: [String]
    let correctAnswer: String
    let explanation: String
    let subject: Subject
}

// ============================================================
// File: MyApps/Models/QuestionSet.swift
// ============================================================
//
//  QuestionSet.swift
//  MyApps
//

import Foundation

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy = "Easy"
    case normal = "Normal"
    case hard = "Hard"

    var id: String {
        rawValue
    }
}

struct QuestionSet: Identifiable {
    let id: UUID = UUID()
    let setName: String
    let subject: Subject
    let difficulty: Difficulty
    let questions: [Question]
    var isCompleted = false

    init(
        setName: String,
        subject: Subject,
        difficulty: Difficulty,
        questions: [Question],
        isCompleted: Bool = false
    ) {
        precondition(
            questions.count == 10,
            "Every question set must contain exactly 10 questions."
        )

        self.setName = setName
        self.subject = subject
        self.difficulty = difficulty
        self.questions = questions
        self.isCompleted = isCompleted
    }

    static let sampleQuestionSets: [QuestionSet] = [
        mathematicsSampleSet,
        scienceSampleSet,
        historySampleSet,
        frenchSampleSet
    ]

    static let questionSetProgression: [QuestionSet] = [
        mathematicsSampleSet,
        scienceSampleSet,
        historySampleSet,
        frenchSampleSet,
        mathematicsSecondSet,
        scienceSecondSet,
        historySecondSet,
        frenchSecondSet
    ]

    static func retryQuestionSet(for questionSet: QuestionSet) -> QuestionSet? {
        for availableSet in questionSetProgression {
            if availableSet.subject == questionSet.subject
                && availableSet.setName != questionSet.setName {
                return availableSet
            }
        }
        return nil
    }

    private static let mathematicsSampleSet = QuestionSet(
        setName: "Math Explorers",
        subject: .mathematics,
        difficulty: .normal,
        questions: [
            Question(
                questionText: "What is 7 + 8?",
                answerOptions: ["A. 12", "B. 13", "C. 15", "D. 16"],
                correctAnswer: "C. 15",
                explanation: "Adding 7 and 8 gives 15.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 6 × 4?",
                answerOptions: ["A. 10", "B. 20", "C. 24", "D. 28"],
                correctAnswer: "C. 24",
                explanation: "Six groups of four make 24.",
                subject: .mathematics
            ),
            Question(
                questionText: "Which fraction is equal to one half?",
                answerOptions: ["A. 1/3", "B. 2/4", "C. 3/4", "D. 4/5"],
                correctAnswer: "B. 2/4",
                explanation: "Two out of four equal parts is one half.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is the perimeter of a square with sides of 5 cm?",
                answerOptions: ["A. 10 cm", "B. 15 cm", "C. 20 cm", "D. 25 cm"],
                correctAnswer: "C. 20 cm",
                explanation: "A square has four equal sides, so 4 × 5 = 20 cm.",
                subject: .mathematics
            ),
            Question(
                questionText: "Which number is even?",
                answerOptions: ["A. 17", "B. 23", "C. 31", "D. 42"],
                correctAnswer: "D. 42",
                explanation: "An even number can be divided by 2 with no remainder.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 100 − 37?",
                answerOptions: ["A. 53", "B. 63", "C. 67", "D. 73"],
                correctAnswer: "B. 63",
                explanation: "Subtracting 37 from 100 gives 63.",
                subject: .mathematics
            ),
            Question(
                questionText: "How many sides does a hexagon have?",
                answerOptions: ["A. 5", "B. 6", "C. 7", "D. 8"],
                correctAnswer: "B. 6",
                explanation: "The prefix hex- means six.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 3,000 + 400 + 20 + 6?",
                answerOptions: ["A. 3,246", "B. 3,426", "C. 3,462", "D. 3,624"],
                correctAnswer: "B. 3,426",
                explanation: "The digits represent 3,000 + 400 + 20 + 6 = 3,426.",
                subject: .mathematics
            ),
            Question(
                questionText: "A clock shows 3:30. Where is the minute hand?",
                answerOptions: ["A. On 3", "B. On 6", "C. On 9", "D. On 12"],
                correctAnswer: "B. On 6",
                explanation: "Thirty minutes places the minute hand on 6.",
                subject: .mathematics
            ),
            Question(
                questionText: "What is 45 ÷ 5?",
                answerOptions: ["A. 7", "B. 8", "C. 9", "D. 10"],
                correctAnswer: "C. 9",
                explanation: "Five groups of nine make 45.",
                subject: .mathematics
            )
        ]
    )

    private static let scienceSampleSet = QuestionSet(
        setName: "Science Detectives",
        subject: .science,
        difficulty: .easy,
        questions: [
            Question(
                questionText: "What gas do humans need to breathe?",
                answerOptions: ["A. Oxygen", "B. Helium", "C. Smoke", "D. Steam"],
                correctAnswer: "A. Oxygen",
                explanation: "Humans need oxygen from the air to live.",
                subject: .science
            ),
            Question(
                questionText: "Which part of a plant takes in water?",
                answerOptions: ["A. Flower", "B. Leaf", "C. Root", "D. Fruit"],
                correctAnswer: "C. Root",
                explanation: "Roots take in water and nutrients from the soil.",
                subject: .science
            ),
            Question(
                questionText: "What force pulls objects toward Earth?",
                answerOptions: ["A. Light", "B. Gravity", "C. Sound", "D. Heat"],
                correctAnswer: "B. Gravity",
                explanation: "Gravity pulls objects toward the center of Earth.",
                subject: .science
            ),
            Question(
                questionText: "Which state of matter keeps its own shape?",
                answerOptions: ["A. Solid", "B. Liquid", "C. Gas", "D. Vapor"],
                correctAnswer: "A. Solid",
                explanation: "A solid keeps its own shape and takes up space.",
                subject: .science
            ),
            Question(
                questionText: "What is the closest star to Earth?",
                answerOptions: ["A. The Moon", "B. Mars", "C. The Sun", "D. Jupiter"],
                correctAnswer: "C. The Sun",
                explanation: "The Sun is the star at the center of our solar system.",
                subject: .science
            ),
            Question(
                questionText: "Which animal group has feathers?",
                answerOptions: ["A. Mammals", "B. Fish", "C. Reptiles", "D. Birds"],
                correctAnswer: "D. Birds",
                explanation: "Birds are animals with feathers and beaks.",
                subject: .science
            ),
            Question(
                questionText: "What do we use to see very small objects?",
                answerOptions: ["A. Microscope", "B. Telescope", "C. Compass", "D. Thermometer"],
                correctAnswer: "A. Microscope",
                explanation: "A microscope makes tiny objects look larger.",
                subject: .science
            ),
            Question(
                questionText: "What happens to water when it freezes?",
                answerOptions: ["A. It becomes ice", "B. It becomes steam", "C. It disappears", "D. It becomes sand"],
                correctAnswer: "A. It becomes ice",
                explanation: "Freezing changes liquid water into solid ice.",
                subject: .science
            ),
            Question(
                questionText: "Which organ pumps blood through the body?",
                answerOptions: ["A. Brain", "B. Heart", "C. Stomach", "D. Lung"],
                correctAnswer: "B. Heart",
                explanation: "The heart pumps blood to all parts of the body.",
                subject: .science
            ),
            Question(
                questionText: "What is a habitat?",
                answerOptions: ["A. An animal's home", "B. A type of cloud", "C. A kind of rock", "D. A food chain"],
                correctAnswer: "A. An animal's home",
                explanation: "A habitat is the place where a plant or animal lives.",
                subject: .science
            )
        ]
    )

    private static let historySampleSet = QuestionSet(
        setName: "History Time Travelers",
        subject: .history,
        difficulty: .normal,
        questions: [
            Question(
                questionText: "Which ancient people built the pyramids at Giza?",
                answerOptions: ["A. Egyptians", "B. Vikings", "C. Romans", "D. Aztecs"],
                correctAnswer: "A. Egyptians",
                explanation: "The ancient Egyptians built the pyramids at Giza.",
                subject: .history
            ),
            Question(
                questionText: "What do we call a person who studies the past?",
                answerOptions: ["A. Scientist", "B. Historian", "C. Pilot", "D. Artist"],
                correctAnswer: "B. Historian",
                explanation: "A historian researches and explains events from the past.",
                subject: .history
            ),
            Question(
                questionText: "Which invention helps people print many copies of a book?",
                answerOptions: ["A. Compass", "B. Printing press", "C. Telescope", "D. Telephone"],
                correctAnswer: "B. Printing press",
                explanation: "The printing press made it faster to produce books.",
                subject: .history
            ),
            Question(
                questionText: "What is a timeline used to show?",
                answerOptions: ["A. Events in order", "B. Weather each day", "C. A map's colors", "D. Animal sizes"],
                correctAnswer: "A. Events in order",
                explanation: "A timeline puts events in the order they happened.",
                subject: .history
            ),
            Question(
                questionText: "Which object can give us information about the past?",
                answerOptions: ["A. Artifact", "B. Rainbow", "C. Shadow", "D. Snowflake"],
                correctAnswer: "A. Artifact",
                explanation: "An artifact is an object made or used by people in the past.",
                subject: .history
            ),
            Question(
                questionText: "What was a castle mainly built to provide?",
                answerOptions: ["A. Protection", "B. A swimming pool", "C. A library card", "D. A garden tool"],
                correctAnswer: "A. Protection",
                explanation: "Castles were often built to protect people from attacks.",
                subject: .history
            ),
            Question(
                questionText: "Which transportation was used before cars and airplanes?",
                answerOptions: ["A. Horse-drawn wagon", "B. Space shuttle", "C. Electric scooter", "D. Subway train"],
                correctAnswer: "A. Horse-drawn wagon",
                explanation: "People traveled in horse-drawn wagons long before modern vehicles.",
                subject: .history
            ),
            Question(
                questionText: "What is a primary source?",
                answerOptions: ["A. Evidence from the time", "B. A modern guess", "C. A fictional story", "D. A math problem"],
                correctAnswer: "A. Evidence from the time",
                explanation: "A primary source comes directly from the time being studied.",
                subject: .history
            ),
            Question(
                questionText: "Why did early people make maps?",
                answerOptions: ["A. To show places", "B. To cook food", "C. To measure sound", "D. To grow plants"],
                correctAnswer: "A. To show places",
                explanation: "Maps help people understand where places are located.",
                subject: .history
            ),
            Question(
                questionText: "What does a museum usually preserve?",
                answerOptions: ["A. Historical objects", "B. Fresh lunches", "C. New shoes", "D. Clouds"],
                correctAnswer: "A. Historical objects",
                explanation: "Museums protect and display objects that teach us about the past.",
                subject: .history
            )
        ]
    )

    private static let frenchSampleSet = QuestionSet(
        setName: "French Friends",
        subject: .french,
        difficulty: .easy,
        questions: [
            Question(
                questionText: "What does 'bonjour' mean?",
                answerOptions: ["A. Goodbye", "B. Hello", "C. Thank you", "D. Please"],
                correctAnswer: "B. Hello",
                explanation: "Bonjour is a friendly way to say hello in French.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'one'?",
                answerOptions: ["A. Deux", "B. Trois", "C. Un", "D. Quatre"],
                correctAnswer: "C. Un",
                explanation: "Un means one in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'merci' mean?",
                answerOptions: ["A. Thank you", "B. Good morning", "C. Friend", "D. Yes"],
                correctAnswer: "A. Thank you",
                explanation: "Merci is the French word for thank you.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'red'?",
                answerOptions: ["A. Bleu", "B. Vert", "C. Rouge", "D. Jaune"],
                correctAnswer: "C. Rouge",
                explanation: "Rouge means red in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'chat' mean in English?",
                answerOptions: ["A. Dog", "B. Cat", "C. Bird", "D. Fish"],
                correctAnswer: "B. Cat",
                explanation: "Chat means cat in French.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'school'?",
                answerOptions: ["A. Maison", "B. Livre", "C. École", "D. Jardin"],
                correctAnswer: "C. École",
                explanation: "École means school in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'au revoir' mean?",
                answerOptions: ["A. See you later", "B. Good night", "C. Welcome", "D. Excuse me"],
                correctAnswer: "A. See you later",
                explanation: "Au revoir is a way to say goodbye or see you later.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'blue'?",
                answerOptions: ["A. Blanc", "B. Bleu", "C. Noir", "D. Rose"],
                correctAnswer: "B. Bleu",
                explanation: "Bleu means blue in French.",
                subject: .french
            ),
            Question(
                questionText: "What does 'ami' mean?",
                answerOptions: ["A. Teacher", "B. Friend", "C. Student", "D. Brother"],
                correctAnswer: "B. Friend",
                explanation: "Ami means friend in French.",
                subject: .french
            ),
            Question(
                questionText: "What is the French word for 'two'?",
                answerOptions: ["A. Un", "B. Deux", "C. Cinq", "D. Dix"],
                correctAnswer: "B. Deux",
                explanation: "Deux means two in French.",
                subject: .french
            )
        ]
    )

    private static let mathematicsSecondSet = QuestionSet(
        setName: "Mathematics Set 2",
        subject: .mathematics,
        difficulty: .normal,
        questions: [
            Question(questionText: "What is 9 × 7?", answerOptions: ["A. 56", "B. 63", "C. 72", "D. 81"], correctAnswer: "B. 63", explanation: "Nine groups of seven make 63.", subject: .mathematics),
            Question(questionText: "What is 250 + 175?", answerOptions: ["A. 325", "B. 375", "C. 425", "D. 475"], correctAnswer: "C. 425", explanation: "250 plus 175 equals 425.", subject: .mathematics),
            Question(questionText: "What fraction is shown by 3 out of 8?", answerOptions: ["A. 3/8", "B. 8/3", "C. 3/5", "D. 5/8"], correctAnswer: "A. 3/8", explanation: "Three out of eight equal parts is 3/8.", subject: .mathematics),
            Question(questionText: "How many degrees are in a right angle?", answerOptions: ["A. 45", "B. 60", "C. 90", "D. 180"], correctAnswer: "C. 90", explanation: "A right angle measures 90 degrees.", subject: .mathematics),
            Question(questionText: "What is 144 ÷ 12?", answerOptions: ["A. 10", "B. 12", "C. 14", "D. 16"], correctAnswer: "B. 12", explanation: "Twelve groups of twelve make 144.", subject: .mathematics),
            Question(questionText: "Which number is a multiple of 5?", answerOptions: ["A. 32", "B. 43", "C. 55", "D. 67"], correctAnswer: "C. 55", explanation: "55 can be divided evenly by 5.", subject: .mathematics),
            Question(questionText: "What is 80% of 50?", answerOptions: ["A. 30", "B. 35", "C. 40", "D. 45"], correctAnswer: "C. 40", explanation: "80 percent of 50 is 40.", subject: .mathematics),
            Question(questionText: "A rectangle is 8 cm long and 3 cm wide. What is its area?", answerOptions: ["A. 11 cm²", "B. 22 cm²", "C. 24 cm²", "D. 30 cm²"], correctAnswer: "C. 24 cm²", explanation: "Area equals length times width: 8 × 3 = 24.", subject: .mathematics),
            Question(questionText: "What is the next number: 3, 6, 9, 12, ?", answerOptions: ["A. 13", "B. 14", "C. 15", "D. 16"], correctAnswer: "C. 15", explanation: "The pattern adds 3 each time.", subject: .mathematics),
            Question(questionText: "What is 1,000 − 426?", answerOptions: ["A. 574", "B. 624", "C. 676", "D. 684"], correctAnswer: "A. 574", explanation: "Subtracting 426 from 1,000 gives 574.", subject: .mathematics)
        ]
    )

    private static let scienceSecondSet = QuestionSet(
        setName: "Science Set 2",
        subject: .science,
        difficulty: .normal,
        questions: [
            Question(questionText: "Which organ pumps blood through the body?", answerOptions: ["A. Heart", "B. Brain", "C. Lung", "D. Kidney"], correctAnswer: "A. Heart", explanation: "The heart pumps blood through the circulatory system.", subject: .science),
            Question(questionText: "What is the process plants use to make food?", answerOptions: ["A. Digestion", "B. Evaporation", "C. Photosynthesis", "D. Respiration"], correctAnswer: "C. Photosynthesis", explanation: "Photosynthesis uses sunlight to make plant food.", subject: .science),
            Question(questionText: "Which planet is known as the Red Planet?", answerOptions: ["A. Venus", "B. Mars", "C. Jupiter", "D. Saturn"], correctAnswer: "B. Mars", explanation: "Mars appears red because of iron-rich dust.", subject: .science),
            Question(questionText: "Which instrument measures temperature?", answerOptions: ["A. Compass", "B. Thermometer", "C. Telescope", "D. Microscope"], correctAnswer: "B. Thermometer", explanation: "A thermometer measures how hot or cold something is.", subject: .science),
            Question(questionText: "What type of animal is a frog?", answerOptions: ["A. Amphibian", "B. Reptile", "C. Mammal", "D. Fish"], correctAnswer: "A. Amphibian", explanation: "Frogs are amphibians that begin life in water.", subject: .science),
            Question(questionText: "Which layer of Earth do we live on?", answerOptions: ["A. Core", "B. Mantle", "C. Crust", "D. Magma"], correctAnswer: "C. Crust", explanation: "People live on Earth's outer solid layer, the crust.", subject: .science),
            Question(questionText: "What happens to liquid water when it evaporates?", answerOptions: ["A. It becomes vapor", "B. It becomes ice", "C. It becomes rock", "D. It becomes sand"], correctAnswer: "A. It becomes vapor", explanation: "Evaporation changes liquid water into water vapor.", subject: .science),
            Question(questionText: "Which sense is used to detect smells?", answerOptions: ["A. Sight", "B. Taste", "C. Hearing", "D. Smell"], correctAnswer: "D. Smell", explanation: "The nose detects different smells.", subject: .science),
            Question(questionText: "What do caterpillars become?", answerOptions: ["A. Frogs", "B. Butterflies", "C. Fish", "D. Birds"], correctAnswer: "B. Butterflies", explanation: "A caterpillar transforms into a butterfly or moth.", subject: .science),
            Question(questionText: "Which resource is renewable?", answerOptions: ["A. Coal", "B. Oil", "C. Sunlight", "D. Natural gas"], correctAnswer: "C. Sunlight", explanation: "Sunlight is continuously renewed by the Sun.", subject: .science)
        ]
    )

    private static let historySecondSet = QuestionSet(
        setName: "History Set 2",
        subject: .history,
        difficulty: .normal,
        questions: [
            Question(questionText: "Who was the first U.S. president?", answerOptions: ["A. George Washington", "B. Abraham Lincoln", "C. Thomas Jefferson", "D. John Adams"], correctAnswer: "A. George Washington", explanation: "George Washington served as the first U.S. president.", subject: .history),
            Question(questionText: "Which civilization used hieroglyphics?", answerOptions: ["A. Ancient Egypt", "B. Ancient Greece", "C. Viking lands", "D. China"], correctAnswer: "A. Ancient Egypt", explanation: "Ancient Egyptians used hieroglyphics for writing.", subject: .history),
            Question(questionText: "What tool does an archaeologist use to find artifacts?", answerOptions: ["A. Excavation tools", "B. Telescope", "C. Microscope", "D. Compass only"], correctAnswer: "A. Excavation tools", explanation: "Archaeologists carefully excavate sites to find artifacts.", subject: .history),
            Question(questionText: "The Renaissance began in which country?", answerOptions: ["A. Italy", "B. Australia", "C. Canada", "D. Japan"], correctAnswer: "A. Italy", explanation: "The Renaissance began in Italian city-states.", subject: .history),
            Question(questionText: "Which invention helped people print books faster?", answerOptions: ["A. Printing press", "B. Compass", "C. Steam engine", "D. Telescope"], correctAnswer: "A. Printing press", explanation: "The printing press made books easier and faster to produce.", subject: .history),
            Question(questionText: "What was the main purpose of ancient castles?", answerOptions: ["A. Defense", "B. Farming", "C. Painting", "D. Swimming"], correctAnswer: "A. Defense", explanation: "Castles protected people and territory.", subject: .history),
            Question(questionText: "Which civilization built Machu Picchu?", answerOptions: ["A. Inca", "B. Roman", "C. Persian", "D. Egyptian"], correctAnswer: "A. Inca", explanation: "The Inca civilization built Machu Picchu.", subject: .history),
            Question(questionText: "What system uses kings or queens as rulers?", answerOptions: ["A. Monarchy", "B. Democracy", "C. Republic", "D. Federation"], correctAnswer: "A. Monarchy", explanation: "A monarchy is ruled by a king or queen.", subject: .history),
            Question(questionText: "Why is the Rosetta Stone important?", answerOptions: ["A. It helped decode Egyptian writing", "B. It is a map", "C. It is a weapon", "D. It is a modern book"], correctAnswer: "A. It helped decode Egyptian writing", explanation: "The Rosetta Stone helped scholars understand hieroglyphics.", subject: .history),
            Question(questionText: "Which people lived in longhouses in parts of North America?", answerOptions: ["A. Haudenosaunee", "B. Vikings", "C. Romans", "D. Egyptians"], correctAnswer: "A. Haudenosaunee", explanation: "The Haudenosaunee built and lived in longhouses.", subject: .history)
        ]
    )

    private static let frenchSecondSet = QuestionSet(
        setName: "French Set 2",
        subject: .french,
        difficulty: .normal,
        questions: [
            Question(questionText: "What does 'bonsoir' mean?", answerOptions: ["A. Good evening", "B. Good morning", "C. Good night", "D. See you soon"], correctAnswer: "A. Good evening", explanation: "Bonsoir means good evening.", subject: .french),
            Question(questionText: "What is the French word for 'girl'?", answerOptions: ["A. Garçon", "B. Fille", "C. Homme", "D. Femme"], correctAnswer: "B. Fille", explanation: "Fille means girl.", subject: .french),
            Question(questionText: "What does 'livre' mean?", answerOptions: ["A. Apple", "B. Car", "C. Book", "D. Chair"], correctAnswer: "C. Book", explanation: "Livre means book.", subject: .french),
            Question(questionText: "What is 'five' in French?", answerOptions: ["A. Quatre", "B. Cinq", "C. Six", "D. Sept"], correctAnswer: "B. Cinq", explanation: "Cinq means five.", subject: .french),
            Question(questionText: "What does 'porte' mean?", answerOptions: ["A. Door", "B. Window", "C. Table", "D. Floor"], correctAnswer: "A. Door", explanation: "Porte means door.", subject: .french),
            Question(questionText: "What is the French word for 'white'?", answerOptions: ["A. Noir", "B. Blanc", "C. Gris", "D. Orange"], correctAnswer: "B. Blanc", explanation: "Blanc means white.", subject: .french),
            Question(questionText: "What does 'chien' mean?", answerOptions: ["A. Dog", "B. Cat", "C. Horse", "D. Rabbit"], correctAnswer: "A. Dog", explanation: "Chien means dog.", subject: .french),
            Question(questionText: "What is 'water' in French?", answerOptions: ["A. Eau", "B. Pain", "C. Fromage", "D. Lait"], correctAnswer: "A. Eau", explanation: "Eau means water.", subject: .french),
            Question(questionText: "What does 'petit' mean?", answerOptions: ["A. Big", "B. Small", "C. Fast", "D. Slow"], correctAnswer: "B. Small", explanation: "Petit means small.", subject: .french),
            Question(questionText: "What is 'goodbye' in French?", answerOptions: ["A. Salut", "B. Bonjour", "C. Merci", "D. S'il vous plaît"], correctAnswer: "A. Salut", explanation: "Salut can mean hello or goodbye informally.", subject: .french)
        ]
    )
}

// ============================================================
// File: MyApps/Models/ShopItem.swift
// ============================================================
//
//  ShopItem.swift
//  MyApps
//

import Foundation

enum ShopItemCategory: String, Codable {
    case shirt = "Shirts"
    case hairstyle = "Hairstyles"
    case hat = "Hats"
    case glasses = "Glasses"
    case accessory = "Other Accessories"
}

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let trophyPrice: Int
    let category: ShopItemCategory
    let symbol: String
}

// ============================================================
// File: MyApps/Models/Trophy.swift
// ============================================================
//
//  Trophy.swift
//  MyApps
//

struct Trophy {
}

// ============================================================
// File: MyApps/ViewModels/CharacterViewModel.swift
// ============================================================
//
//  CharacterViewModel.swift
//  MyApps
//

import Observation

@Observable
@MainActor
final class CharacterViewModel {
    var character: Character

    let skinToneOptions = ["Light", "Medium", "Dark"]
    let eyeColorOptions = ["Blue", "Green", "Brown"]
    let hairstyleOptions = ["Short", "Curly", "Ponytail"]
    let hairColorOptions = ["Black", "Brown", "Blonde"]
    let outfitOptions = ["Casual", "Sporty", "Fancy"]
    let accessoryOptions = ["None", "Glasses", "Hat"]

    init(character: Character = Character()) {
        self.character = character
    }

    func selectSkinTone(_ skinTone: String) {
        character.skinTone = skinTone
    }

    func selectEyeColor(_ eyeColor: String) {
        character.eyeColor = eyeColor
    }

    func selectHairstyle(_ hairstyle: String) {
        character.hairstyle = hairstyle
    }

    func selectHairColor(_ hairColor: String) {
        character.hairColor = hairColor
    }

    func selectOutfit(_ outfit: String) {
        character.outfit = outfit
    }

    func selectAccessory(_ accessory: String) {
        character.accessories = accessory
    }
}

// ============================================================
// File: MyApps/ViewModels/HomeViewModel.swift
// ============================================================
//
//  HomeViewModel.swift
//  MyApps
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    let shopViewModel: ShopViewModel
    let historyViewModel: HistoryViewModel
    private let dataStore: LocalDataStore
    private(set) var currentQuestionSetIndex: Int
    private(set) var questionSetProgression: [QuestionSet]
    private(set) var awardedQuestionSetNames: [String]

    init(
        dataStore: LocalDataStore = .shared,
        initialCharacter: Character? = nil
    ) {
        self.dataStore = dataStore
        let savedProgress = dataStore.loadProgress()
        let characterToRestore = initialCharacter ?? savedProgress.character

        let savedShopViewModel = ShopViewModel(
            initialTrophyBalance: savedProgress.trophyCount,
            initialCharacter: characterToRestore,
            purchasedItemNames: savedProgress.purchasedItemNames,
            equippedItemNames: savedProgress.equippedItemNames
        )
        let savedHistoryViewModel = HistoryViewModel(
            completedQuestions: savedProgress.completedQuestions,
            incorrectQuestions: savedProgress.incorrectQuestions
        )

        var savedQuestionSetProgression = QuestionSet.questionSetProgression
        for index in savedQuestionSetProgression.indices {
            let setName = savedQuestionSetProgression[index].setName
            if savedProgress.completedQuestionSetNames.contains(setName) {
                savedQuestionSetProgression[index].isCompleted = true
            }
        }

        let savedIndex = savedProgress.currentQuestionSetIndex
        let startingQuestionSetIndex = savedIndex >= 0
            && savedIndex < savedQuestionSetProgression.count
            ? savedIndex
            : 0

        shopViewModel = savedShopViewModel
        historyViewModel = savedHistoryViewModel
        questionSetProgression = savedQuestionSetProgression
        currentQuestionSetIndex = startingQuestionSetIndex
        awardedQuestionSetNames = savedProgress.awardedQuestionSetNames

        shopViewModel.onChange = { [weak self] in
            self?.saveProgress()
        }
        historyViewModel.onChange = { [weak self] in
            self?.saveProgress()
        }

        if initialCharacter != nil {
            saveProgress()
        }
    }

    var character: Character {
        get {
            shopViewModel.character
        }
        set {
            shopViewModel.character = newValue
        }
    }

    var trophyCount: Int {
        shopViewModel.trophyBalance
    }

    var currentQuestionSet: QuestionSet {
        questionSetProgression[currentQuestionSetIndex]
    }

    func questionSet(withID id: UUID) -> QuestionSet? {
        questionSetProgression.first { questionSet in
            questionSet.id == id
        }
    }

    func updateCharacter(_ character: Character) {
        shopViewModel.updateCharacter(character)
        saveProgress()
    }

    func awardTrophy() {
        shopViewModel.awardTrophy()
        saveProgress()
    }

    func completeCurrentQuestionSet() {
        guard currentQuestionSet.isCompleted == false else {
            return
        }

        questionSetProgression[currentQuestionSetIndex].isCompleted = true
        let completedSetName = currentQuestionSet.setName
        if awardedQuestionSetNames.contains(completedSetName) == false {
            awardedQuestionSetNames.append(completedSetName)
            shopViewModel.awardTrophy()
        }

        if currentQuestionSetIndex < questionSetProgression.count - 1 {
            currentQuestionSetIndex += 1
        }
        saveProgress()
    }

    private func saveProgress() {
        var completedSetNames: [String] = []
        for questionSet in questionSetProgression {
            if questionSet.isCompleted {
                completedSetNames.append(questionSet.setName)
            }
        }

        let progress = AppProgress(
            character: shopViewModel.character,
            trophyCount: shopViewModel.trophyBalance,
            awardedQuestionSetNames: awardedQuestionSetNames,
            currentQuestionSetIndex: currentQuestionSetIndex,
            completedQuestionSetNames: completedSetNames,
            completedQuestions: historyViewModel.completedQuestions,
            incorrectQuestions: historyViewModel.incorrectQuestions,
            purchasedItemNames: shopViewModel.purchasedItemNames,
            equippedItemNames: shopViewModel.equippedItemNames
        )
        dataStore.saveProgress(progress)
    }

}

@Observable
@MainActor
final class HistoryViewModel {
    private(set) var completedQuestions: [CompletedQuestionRecord] = []
    private(set) var incorrectQuestions: [IncorrectQuestionRecord] = []
    var onChange: () -> Void = {}

    init(
        completedQuestions: [CompletedQuestionRecord] = [],
        incorrectQuestions: [IncorrectQuestionRecord] = []
    ) {
        self.completedQuestions = completedQuestions
        self.incorrectQuestions = incorrectQuestions
    }

    func recordCompletedQuestion(
        question: Question,
        selectedAnswer: String,
        questionSetName: String
    ) {
        let record = CompletedQuestionRecord(
            questionText: question.questionText,
            selectedAnswer: selectedAnswer,
            correctAnswer: question.correctAnswer,
            questionSetName: questionSetName,
            subject: question.subject,
            completedDate: Date()
        )

        completedQuestions.insert(record, at: 0)
        onChange()
    }

    func recordIncorrectQuestion(
        question: Question,
        incorrectAnswer: String,
        questionSetName: String
    ) {
        let record = IncorrectQuestionRecord(
            questionText: question.questionText,
            incorrectAnswer: incorrectAnswer,
            correctAnswer: question.correctAnswer,
            questionSetName: questionSetName,
            subject: question.subject,
            explanation: question.explanation,
            answeredDate: Date()
        )

        incorrectQuestions.insert(record, at: 0)
        onChange()
    }
}

// ============================================================
// File: MyApps/ViewModels/QuizViewModel.swift
// ============================================================
//
//  QuizViewModel.swift
//  MyApps
//

import Observation

@Observable
@MainActor
final class QuizViewModel {
    private(set) var questionSet: QuestionSet
    let alternativeQuestionSet: QuestionSet?
    let historyViewModel: HistoryViewModel
    private(set) var currentQuestionIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var isAnswerCorrect = false
    private(set) var hasAnsweredCurrentQuestion = false
    private(set) var feedbackMessage = ""
    private(set) var incorrectlyAnsweredQuestions: [Question] = []
    private(set) var isQuizComplete = false

    init(
        questionSet: QuestionSet,
        alternativeQuestionSet: QuestionSet? = nil,
        historyViewModel: HistoryViewModel
    ) {
        self.questionSet = questionSet
        self.alternativeQuestionSet = alternativeQuestionSet
        self.historyViewModel = historyViewModel
    }

    var currentQuestion: Question {
        questionSet.questions[currentQuestionIndex]
    }

    var questionNumber: Int {
        currentQuestionIndex + 1
    }

    var progressValue: Double {
        Double(questionNumber) / Double(questionSet.questions.count)
    }

    var correctAnswer: String {
        currentQuestion.correctAnswer
    }

    var explanation: String {
        currentQuestion.explanation
    }

    func submitAnswer(_ answer: String) {
        guard hasAnsweredCurrentQuestion == false else {
            return
        }

        selectedAnswer = answer
        hasAnsweredCurrentQuestion = true

        if answer == currentQuestion.correctAnswer {
            isAnswerCorrect = true
            feedbackMessage = "Correct! Great job!"
            historyViewModel.recordCompletedQuestion(
                question: currentQuestion,
                selectedAnswer: answer,
                questionSetName: questionSet.setName
            )

            if currentQuestionIndex == questionSet.questions.count - 1 {
                isQuizComplete = true
            }
        } else {
            isAnswerCorrect = false
            feedbackMessage = "Not quite. Let’s learn from this one!"
            incorrectlyAnsweredQuestions.append(currentQuestion)
            historyViewModel.recordIncorrectQuestion(
                question: currentQuestion,
                incorrectAnswer: answer,
                questionSetName: questionSet.setName
            )
        }
    }

    func moveToNextQuestion() {
        guard hasAnsweredCurrentQuestion,
              isAnswerCorrect,
              isQuizComplete == false else {
            return
        }

        currentQuestionIndex += 1
        clearAnswerState()
    }

    func resetQuizProgress() {
        if let alternativeQuestionSet {
            questionSet = alternativeQuestionSet
        }
        currentQuestionIndex = 0
        isQuizComplete = false
        clearAnswerState()
    }

    private func clearAnswerState() {
        selectedAnswer = nil
        isAnswerCorrect = false
        hasAnsweredCurrentQuestion = false
        feedbackMessage = ""
    }
}

// ============================================================
// File: MyApps/ViewModels/ShopViewModel.swift
// ============================================================
//
//  ShopViewModel.swift
//  MyApps
//

import Foundation
import Observation

@Observable
@MainActor
final class ShopViewModel {
    // MARK: - Character and Trophy State

    var character: Character
    private(set) var trophyBalance: Int
    private(set) var purchasedItemIDs: [UUID] = []
    private(set) var equippedItemIDs: [UUID] = []
    private(set) var purchaseMessage = ""
    var onChange: () -> Void = {}

    // MARK: - Shop Items

    // LIST: This array stores every shop item used by the app.
    // It makes the shop easier to build, update, and display.
    let availableItems: [ShopItem] = [
        ShopItem(name: "Red Shirt", trophyPrice: 2, category: .shirt, symbol: "👕"),
        ShopItem(name: "Sporty Shirt", trophyPrice: 3, category: .shirt, symbol: "🎽"),
        ShopItem(name: "Fancy Shirt", trophyPrice: 4, category: .shirt, symbol: "👔"),
        ShopItem(name: "Curly Hairstyle", trophyPrice: 3, category: .hairstyle, symbol: "〰️"),
        ShopItem(name: "Ponytail Hairstyle", trophyPrice: 4, category: .hairstyle, symbol: "🎀"),
        ShopItem(name: "Blue Hat", trophyPrice: 3, category: .hat, symbol: "🧢"),
        ShopItem(name: "Crown", trophyPrice: 6, category: .hat, symbol: "👑"),
        ShopItem(name: "Round Glasses", trophyPrice: 3, category: .glasses, symbol: "👓"),
        ShopItem(name: "Sun Glasses", trophyPrice: 5, category: .glasses, symbol: "🕶️"),
        ShopItem(name: "Backpack", trophyPrice: 4, category: .accessory, symbol: "🎒"),
        ShopItem(name: "Necklace", trophyPrice: 5, category: .accessory, symbol: "📿")
    ]

    init(
        initialTrophyBalance: Int,
        initialCharacter: Character,
        purchasedItemNames: [String] = [],
        equippedItemNames: [String] = []
    ) {
        trophyBalance = initialTrophyBalance
        character = initialCharacter

        for item in availableItems {
            if purchasedItemNames.contains(item.name) {
                purchasedItemIDs.append(item.id)
            }
            if equippedItemNames.contains(item.name) {
                equippedItemIDs.append(item.id)
            }
        }
    }

    // MARK: - Purchasing

    func purchaseItem(_ item: ShopItem) {
        if purchasedItemIDs.contains(item.id) {
            purchaseMessage = "\(item.name) is already unlocked."
            return
        }

        if trophyBalance < item.trophyPrice {
            purchaseMessage = "You need \(item.trophyPrice - trophyBalance) more trophy for \(item.name)."
            return
        }

        trophyBalance -= item.trophyPrice
        purchasedItemIDs.append(item.id)
        purchaseMessage = "\(item.name) unlocked!"
        onChange()
    }

    // MARK: - Equipping

    // PROCEDURE: equipItem uses the item parameter to change which item
    // is equipped. It uses sequencing, an if selection, and a for loop.
    func equipItem(_ item: ShopItem) {
        if purchasedItemIDs.contains(item.id) == false {
            purchaseMessage = "Purchase \(item.name) before equipping it."
            return
        }

        for existingItem in availableItems {
            if existingItem.category == item.category
                && equippedItemIDs.contains(existingItem.id) {
                equippedItemIDs.removeAll { equippedID in
                    equippedID == existingItem.id
                }
            }
        }

        equippedItemIDs.append(item.id)

        switch item.category {
        case .shirt:
            character.outfit = item.name
        case .hairstyle:
            character.hairstyle = item.name
        case .hat:
            character.accessories = item.name
        case .glasses:
            character.accessories = item.name
        case .accessory:
            character.accessories = item.name
        }

        purchaseMessage = "\(item.name) equipped!"
        onChange()
    }

    func isPurchased(_ item: ShopItem) -> Bool {
        purchasedItemIDs.contains(item.id)
    }

    func isEquipped(_ item: ShopItem) -> Bool {
        equippedItemIDs.contains(item.id)
    }

    // MARK: - Shared Character and Trophy Updates

    func updateCharacter(_ character: Character) {
        self.character = character
        onChange()
    }

    func awardTrophy() {
        trophyBalance += 1
        onChange()
    }

    var purchasedItemNames: [String] {
        var names: [String] = []
        for item in availableItems {
            if purchasedItemIDs.contains(item.id) {
                names.append(item.name)
            }
        }
        return names
    }

    var equippedItemNames: [String] {
        var names: [String] = []
        for item in availableItems {
            if equippedItemIDs.contains(item.id) {
                names.append(item.name)
            }
        }
        return names
    }
}

// ============================================================
// File: MyApps/Views/CharacterIllustration.swift
// ============================================================
//
//  CharacterIllustration.swift
//  MyApps
//

import SwiftUI

struct CharacterIllustration: View {
    let character: Character
    let size: CGFloat

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                face
                    .overlay(alignment: .top) {
                        hair
                    }
                    .overlay(alignment: .leading) {
                        if character.accessories == "Glasses"
                            || character.accessories == "Round Glasses"
                            || character.accessories == "Sun Glasses" {
                            glasses
                        }
                    }

                bodySection
            }

            hat
                .offset(y: -size * 0.34)

            accessory
        }
        .frame(width: size, height: size)
    }

    private var face: some View {
        ZStack {
            Circle()
                .fill(skinToneColor)

            HStack(spacing: size * 0.16) {
                Capsule()
                    .fill(eyeColor)
                    .frame(width: size * 0.055, height: size * 0.035)

                Capsule()
                    .fill(eyeColor)
                    .frame(width: size * 0.055, height: size * 0.035)
            }
            .offset(y: size * 0.03)

            VStack(spacing: size * 0.06) {
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(.primary.opacity(0.45))
                    .frame(width: size * 0.08, height: size * 0.018)
            }
            .offset(y: size * 0.15)
        }
        .frame(width: size * 0.58, height: size * 0.58)
    }

    @ViewBuilder
    private var hair: some View {
        if character.hairstyle == "Ponytail" {
            ZStack(alignment: .trailing) {
                Ellipse()
                    .fill(hairColor)
                    .frame(width: size * 0.58, height: size * 0.16)
                    .offset(y: -size * 0.22)

                Capsule()
                    .fill(hairColor)
                    .frame(width: size * 0.16, height: size * 0.28)
                    .rotationEffect(.degrees(-18))
                    .offset(x: size * 0.38, y: size * 0.06)
            }
        } else if character.hairstyle == "Curly" {
            ZStack {
                ForEach(0..<7, id: \.self) { index in
                    Circle()
                        .fill(hairColor)
                        .frame(width: size * 0.16, height: size * 0.16)
                        .offset(
                            x: CGFloat(index - 3) * size * 0.09,
                            y: -size * 0.26
                        )
                }
            }
        } else {
            Ellipse()
                .fill(hairColor)
                .frame(width: size * 0.58, height: size * 0.16)
                .offset(y: -size * 0.22)
        }
    }

    private var bodySection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.12)
                .fill(shirtColor)
                .frame(width: size * 0.62, height: size * 0.30)

            Circle()
                .fill(skinToneColor)
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(x: -size * 0.42)

            Circle()
                .fill(skinToneColor)
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(x: size * 0.42)
        }
        .offset(y: -size * 0.02)
    }

    private var glasses: some View {
        HStack(spacing: size * 0.08) {
            Circle()
                .stroke(.primary, lineWidth: max(1, size * 0.018))
                .frame(width: size * 0.17, height: size * 0.17)
            Circle()
                .stroke(.primary, lineWidth: max(1, size * 0.018))
                .frame(width: size * 0.17, height: size * 0.17)
        }
        .offset(x: size * 0.12, y: size * 0.01)
    }

    @ViewBuilder
    private var hat: some View {
        if character.accessories == "Hat"
            || character.accessories == "Blue Hat"
            || character.accessories == "Crown" {
            ZStack(alignment: .bottom) {
                if character.accessories == "Crown" {
                    CrownShape()
                        .fill(.yellow)
                        .frame(width: size * 0.42, height: size * 0.20)
                } else {
                    RoundedRectangle(cornerRadius: size * 0.04)
                        .fill(.blue)
                        .frame(width: size * 0.46, height: size * 0.16)
                }
            }
        }
    }

    @ViewBuilder
    private var accessory: some View {
        if character.accessories == "Backpack" {
            RoundedRectangle(cornerRadius: size * 0.06)
                .fill(.brown)
                .frame(width: size * 0.22, height: size * 0.28)
                .offset(x: size * 0.38, y: size * 0.18)
        } else if character.accessories == "Necklace" {
            Circle()
                .stroke(.yellow, lineWidth: max(2, size * 0.018))
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(y: size * 0.18)
        }
    }

    private var skinToneColor: Color {
        switch character.skinTone {
        case "Light":
            return Color(red: 1.0, green: 0.82, blue: 0.68)
        case "Dark":
            return Color(red: 0.38, green: 0.20, blue: 0.10)
        default:
            return Color(red: 0.72, green: 0.45, blue: 0.28)
        }
    }

    private var eyeColor: Color {
        switch character.eyeColor {
        case "Blue":
            return .blue
        case "Green":
            return .green
        default:
            return .brown
        }
    }

    private var hairColor: Color {
        switch character.hairColor {
        case "Black":
            return .black
        case "Blonde":
            return .yellow
        default:
            return .brown
        }
    }

    private var shirtColor: Color {
        if character.outfit.contains("Sporty") {
            return .green
        }
        if character.outfit.contains("Fancy") {
            return .purple
        }
        if character.outfit.contains("Red Shirt") {
            return .red
        }
        return .blue
    }
}

private struct CrownShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.25, y: rect.midY * 0.55))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.25, y: rect.midY * 0.55))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// ============================================================
// File: MyApps/Views/CharacterView.swift
// ============================================================
//
//  CharacterView.swift
//  MyApps
//

import SwiftUI

struct CharacterView: View {
    @State private var viewModel: CharacterViewModel
    @Environment(\.dismiss) private var dismiss

    let onContinue: (Character) -> Void

    init(
        initialCharacter: Character = Character(),
        onContinue: @escaping (Character) -> Void = { _ in }
    ) {
        _viewModel = State(initialValue: CharacterViewModel(character: initialCharacter))
        self.onContinue = onContinue
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                characterPreview

                selectionSection(
                    title: "Skin tone",
                    options: viewModel.skinToneOptions,
                    selectedOption: viewModel.character.skinTone
                ) { selectedOption in
                    viewModel.selectSkinTone(selectedOption)
                }

                selectionSection(
                    title: "Eye color",
                    options: viewModel.eyeColorOptions,
                    selectedOption: viewModel.character.eyeColor
                ) { selectedOption in
                    viewModel.selectEyeColor(selectedOption)
                }

                selectionSection(
                    title: "Hairstyle",
                    options: viewModel.hairstyleOptions,
                    selectedOption: viewModel.character.hairstyle
                ) { selectedOption in
                    viewModel.selectHairstyle(selectedOption)
                }

                selectionSection(
                    title: "Hair color",
                    options: viewModel.hairColorOptions,
                    selectedOption: viewModel.character.hairColor
                ) { selectedOption in
                    viewModel.selectHairColor(selectedOption)
                }

                selectionSection(
                    title: "Outfit",
                    options: viewModel.outfitOptions,
                    selectedOption: viewModel.character.outfit
                ) { selectedOption in
                    viewModel.selectOutfit(selectedOption)
                }

                selectionSection(
                    title: "Accessories",
                    options: viewModel.accessoryOptions,
                    selectedOption: viewModel.character.accessories
                ) { selectedOption in
                    viewModel.selectAccessory(selectedOption)
                }

                Button("Continue") {
                    onContinue(viewModel.character)
                    dismiss()
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .clipShape(Capsule())
            }
            .padding()
        }
        .background(Color.yellow.opacity(0.15))
        .navigationTitle("Create Your Character")
    }

    private var characterPreview: some View {
        VStack(spacing: 10) {
            CharacterIllustration(
                character: viewModel.character,
                size: 150
            )

            Text("\(viewModel.character.hairstyle) \(viewModel.character.hairColor) hair")
            Text("\(viewModel.character.outfit) outfit • \(viewModel.character.accessories)")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func selectionSection(
        title: String,
        options: [String],
        selectedOption: String,
        onSelect: @escaping (String) -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button {
                            onSelect(option)
                        } label: {
                            Text(option)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    option == selectedOption
                                        ? Color.orange
                                        : Color.white
                                )
                                .foregroundStyle(
                                    option == selectedOption
                                        ? Color.white
                                        : Color.primary
                                )
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

// ============================================================
// File: MyApps/Views/CompletionView.swift
// ============================================================
//
//  CompletionView.swift
//  MyApps
//

import SwiftUI

struct CompletionView: View {
    let questionSetName: String
    let subjectName: String
    let onReturnToMainMenu: () -> Void

    @State private var trophyScale = 0.5
    @State private var trophyRotation = Angle.degrees(-12)

    init(
        questionSetName: String,
        subjectName: String,
        onReturnToMainMenu: @escaping () -> Void = {}
    ) {
        self.questionSetName = questionSetName
        self.subjectName = subjectName
        self.onReturnToMainMenu = onReturnToMainMenu
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Congratulations!")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text("You completed this question set!")
                .font(.title2)
                .multilineTextAlignment(.center)

            VStack(spacing: 8) {
                Text(subjectName)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(questionSetName)
                    .font(.title2.bold())
            }

            Image(systemName: "trophy.fill")
                .font(.system(size: 90))
                .foregroundStyle(.yellow)
                .shadow(color: .orange.opacity(0.5), radius: 8)
                .scaleEffect(trophyScale)
                .rotationEffect(trophyRotation)
                .accessibilityLabel("Trophy reward")

            Button("Return to Main Menu") {
                onReturnToMainMenu()
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.15))
        .navigationTitle("Completed")
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.65)) {
                trophyScale = 1
                trophyRotation = .zero
            }
        }
    }
}

// ============================================================
// File: MyApps/Views/HistoryView.swift
// ============================================================
//
//  HistoryView.swift
//  MyApps
//

import SwiftUI

struct HistoryView: View {
    @Bindable var viewModel: HistoryViewModel

    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            completedQuestionsSection
            incorrectQuestionsSection
        }
        .navigationTitle("History")
    }

    private var completedQuestionsSection: some View {
        Section("Completed Questions") {
            if viewModel.completedQuestions.isEmpty {
                Text("No completed questions yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.completedQuestions) { record in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(record.questionText)
                            .font(.headline)

                        Text("Your answer: \(record.selectedAnswer)")
                        Text("Correct answer: \(record.correctAnswer)")
                        Text("\(record.questionSetName) • \(record.subject.rawValue)")
                            .foregroundStyle(.secondary)
                        Text(record.completedDate.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private var incorrectQuestionsSection: some View {
        Section("Incorrect Questions") {
            if viewModel.incorrectQuestions.isEmpty {
                Text("No incorrect questions yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.incorrectQuestions) { record in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(record.questionText)
                            .font(.headline)

                        Text("Your answer: \(record.incorrectAnswer)")
                        Text("Correct answer: \(record.correctAnswer)")
                        Text("\(record.questionSetName) • \(record.subject.rawValue)")
                            .foregroundStyle(.secondary)
                        Text(record.explanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(record.answeredDate.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

// ============================================================
// File: MyApps/Views/HomeView.swift
// ============================================================
//
//  HomeView.swift
//  MyApps
//

import SwiftUI

struct HomeView: View {
    private enum Destination: Hashable {
        case quiz(UUID)
        case history
        case character
        case shop
    }

    @State private var viewModel: HomeViewModel
    @State private var isShowingSettings = false
    @State private var navigationPath: [Destination] = []

    init(initialCharacter: Character? = nil) {
        _viewModel = State(
            initialValue: HomeViewModel(initialCharacter: initialCharacter)
        )
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 20) {
                    topArea
                    characterWelcomeArea
                    currentQuestionSetArea
                    bottomNavigationArea
                }
                .padding()
            }
            .background(Color.blue.opacity(0.12))
            .navigationTitle("Adventure Time")
            .alert("Settings", isPresented: $isShowingSettings) {
                Button("OK", role: .cancel) {
                }
            } message: {
                Text("Settings will be available soon!")
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .quiz(let questionSetID):
                    if let questionSet = viewModel.questionSet(withID: questionSetID) {
                        QuizView(
                            questionSet: questionSet,
                            alternativeQuestionSet: QuestionSet.retryQuestionSet(for: questionSet),
                            historyViewModel: viewModel.historyViewModel,
                            onCompleted: {
                                viewModel.completeCurrentQuestionSet()
                            },
                            onReturnToMainMenu: {
                                navigationPath.removeAll()
                            }
                        )
                    }
                case .history:
                    HistoryView(viewModel: viewModel.historyViewModel)
                case .character:
                    CharacterView(initialCharacter: viewModel.character) { selectedCharacter in
                        viewModel.updateCharacter(selectedCharacter)
                    }
                case .shop:
                    ShopView(homeViewModel: viewModel)
                }
            }
        }
    }

    private var topArea: some View {
        HStack {
            Button {
                isShowingSettings = true
            } label: {
                Label("Settings", systemImage: "gearshape.fill")
                    .labelStyle(.iconOnly)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(Color.purple)
                    .clipShape(Circle())
            }
            .accessibilityLabel("Settings")

            Spacer()

            HStack(spacing: 12) {
                Label("\(viewModel.trophyCount)", systemImage: "trophy.fill")
                    .font(.headline)
                    .foregroundStyle(.orange)

                NavigationLink(value: Destination.history) {
                    Label("History", systemImage: "clock.arrow.circlepath")
                        .labelStyle(.iconOnly)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Color.teal)
                        .clipShape(Circle())
                }
                .accessibilityLabel("History")
            }
        }
    }

    private var characterWelcomeArea: some View {
        VStack(spacing: 12) {
            characterPreview

            Text("Welcome, adventurer!")
                .font(.title2.bold())
                .foregroundStyle(.purple)

            Text("Ready to learn something amazing today?")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var characterPreview: some View {
        VStack(spacing: 8) {
            CharacterIllustration(
                character: viewModel.character,
                size: 120
            )

            Text(viewModel.character.accessories)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var currentQuestionSetArea: some View {
        VStack(spacing: 14) {
            Text(viewModel.currentQuestionSet.setName)
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(viewModel.currentQuestionSet.subject.rawValue)
                .font(.largeTitle.bold())
                .foregroundStyle(.blue)

            Text("\(viewModel.currentQuestionSet.questions.count) questions")
                .font(.title3)

            Button {
                navigationPath.append(.quiz(viewModel.currentQuestionSet.id))
            } label: {
                Label("Start Adventure", systemImage: "star.fill")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.yellow.opacity(0.35))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var bottomNavigationArea: some View {
        HStack(spacing: 16) {
            NavigationLink(value: Destination.character) {
                bottomNavigationButton(
                    title: "Character",
                    systemImage: "person.fill",
                    color: .purple
                )
            }

            NavigationLink(value: Destination.shop) {
                bottomNavigationButton(
                    title: "Shop",
                    systemImage: "bag.fill",
                    color: .green
                )
            }
        }
    }

    private func bottomNavigationButton(
        title: String,
        systemImage: String,
        color: Color
    ) -> some View {
        Label(title, systemImage: systemImage)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .clipShape(Capsule())
    }

}

// ============================================================
// File: MyApps/Views/QuizView.swift
// ============================================================
//
//  QuizView.swift
//  MyApps
//

import SwiftUI

struct QuizView: View {
    @State private var viewModel: QuizViewModel
    @State private var shouldShowCompletion = false

    let onCompleted: () -> Void
    let onReturnToMainMenu: () -> Void

    init(
        questionSet: QuestionSet,
        alternativeQuestionSet: QuestionSet? = nil,
        historyViewModel: HistoryViewModel,
        onCompleted: @escaping () -> Void = {},
        onReturnToMainMenu: @escaping () -> Void = {}
    ) {
        _viewModel = State(
            initialValue: QuizViewModel(
                questionSet: questionSet,
                alternativeQuestionSet: alternativeQuestionSet,
                historyViewModel: historyViewModel
            )
        )
        self.onCompleted = onCompleted
        self.onReturnToMainMenu = onReturnToMainMenu
    }

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isQuizComplete {
                Text("All answers are correct!")
                    .font(.title2.bold())
                    .foregroundStyle(.green)
            } else {
                quizHeader
                questionCard
                answerOptions
                feedbackArea
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .navigationTitle(viewModel.questionSet.setName)
        .navigationDestination(isPresented: $shouldShowCompletion) {
            CompletionView(
                questionSetName: viewModel.questionSet.setName,
                subjectName: viewModel.questionSet.subject.rawValue,
                onReturnToMainMenu: onReturnToMainMenu
            )
        }
        .onChange(of: viewModel.isQuizComplete) {
            if viewModel.isQuizComplete {
                onCompleted()
                shouldShowCompletion = true
            }
        }
    }

    private var quizHeader: some View {
        VStack(spacing: 10) {
            Text("Question \(viewModel.questionNumber) / \(viewModel.questionSet.questions.count)")
                .font(.headline)

            ProgressView(value: viewModel.progressValue)
                .tint(.orange)
        }
    }

    private var questionCard: some View {
        Text(viewModel.currentQuestion.questionText)
            .font(.title2.bold())
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var answerOptions: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.currentQuestion.answerOptions, id: \.self) { answer in
                Button {
                    viewModel.submitAnswer(answer)
                } label: {
                    Text(answer)
                        .font(.body.weight(.medium))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(answerBackground(for: answer))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .disabled(viewModel.hasAnsweredCurrentQuestion)
            }
        }
    }

    @ViewBuilder
    private var feedbackArea: some View {
        if viewModel.hasAnsweredCurrentQuestion {
            VStack(spacing: 12) {
                Text(viewModel.feedbackMessage)
                    .font(.headline)
                    .foregroundStyle(viewModel.isAnswerCorrect ? .green : .red)

                if viewModel.isAnswerCorrect {
                    Button("Next Question") {
                        viewModel.moveToNextQuestion()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                } else {
                    VStack(spacing: 6) {
                        Text("Correct answer: \(viewModel.correctAnswer)")
                            .font(.subheadline.bold())

                        Text(viewModel.explanation)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }

                    Button("Try Different Questions") {
                        viewModel.resetQuizProgress()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }

    private func answerBackground(for answer: String) -> Color {
        guard viewModel.hasAnsweredCurrentQuestion else {
            return Color.white
        }

        if answer == viewModel.correctAnswer {
            return Color.green.opacity(0.3)
        }

        if answer == viewModel.selectedAnswer {
            return Color.red.opacity(0.3)
        }

        return Color.white.opacity(0.6)
    }
}

// ============================================================
// File: MyApps/Views/ShopView.swift
// ============================================================
//
//  ShopView.swift
//  MyApps
//

import SwiftUI
import Observation

struct ShopView: View {
    @Bindable var homeViewModel: HomeViewModel

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                trophyBalanceArea
                characterPreview

                if homeViewModel.shopViewModel.purchaseMessage.isEmpty == false {
                    Text(homeViewModel.shopViewModel.purchaseMessage)
                        .font(.subheadline.bold())
                        .foregroundStyle(.purple)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                shopSection(for: ShopItemCategory.shirt)
                shopSection(for: ShopItemCategory.hairstyle)
                shopSection(for: ShopItemCategory.hat)
                shopSection(for: ShopItemCategory.glasses)
                shopSection(for: ShopItemCategory.accessory)
            }
            .padding()
        }
        .background(Color.green.opacity(0.12))
        .navigationTitle("Character Shop")
    }

    private var trophyBalanceArea: some View {
        Label(
            "\(homeViewModel.trophyCount) trophies",
            systemImage: "trophy.fill"
        )
        .font(.title3.bold())
        .foregroundStyle(.orange)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var characterPreview: some View {
        VStack(spacing: 10) {
            CharacterIllustration(
                character: homeViewModel.character,
                size: 130
            )

            Text(homeViewModel.character.accessories)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func shopSection(for category: ShopItemCategory) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(category.rawValue)
                .font(.title3.bold())

            ForEach(homeViewModel.shopViewModel.availableItems) { item in
                if item.category == category {
                    shopItemRow(item)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private func shopItemRow(_ item: ShopItem) -> some View {
        HStack {
            Text(item.symbol)
                .font(.title)
                .frame(width: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)

                if homeViewModel.shopViewModel.isEquipped(item) {
                    Text("Equipped")
                        .font(.caption.bold())
                        .foregroundStyle(.green)
                } else if homeViewModel.shopViewModel.isPurchased(item) {
                    Text("Unlocked")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Label(
                        "\(item.trophyPrice)",
                        systemImage: "trophy.fill"
                    )
                    .font(.caption.bold())
                    .foregroundStyle(.orange)
                }
            }

            Spacer()

            if homeViewModel.shopViewModel.isPurchased(item) {
                Button(
                    homeViewModel.shopViewModel.isEquipped(item)
                        ? "Equipped"
                        : "Equip"
                ) {
                    // PROCEDURE CALL: The shop screen uses equipItem
                    // to equip the selected item during real app use.
                    homeViewModel.shopViewModel.equipItem(item)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .disabled(homeViewModel.shopViewModel.isEquipped(item))
            } else {
                Button("Buy") {
                    homeViewModel.shopViewModel.purchaseItem(item)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding(.vertical, 6)
    }

}
