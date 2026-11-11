//
//  QuestionSet.swift
//  MyApps
//

import Foundation

enum Difficulty: String, CaseIterable, Identifiable {
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
}
