Config = {}
Config.Framework = "esx" -- esx | qb
Config.Inventory = "esx" -- ox | esx | qb
Config.Forms = {
    ["driver_license"] = {
        title = "Los Santos Driver's License",
        description = [[You are about to take the official Los Santos Driver's License Test.
This test will evaluate your ability to follow traffic laws, navigate the roads safely, and demonstrate responsible driving.
You’ll need to obey all signals, speed limits, and road signs while avoiding collisions and reckless behavior.
Drive carefully, follow instructions, and prove that you have what it takes to earn your Los Santos Driver’s License.
Good luck! 🚗💨]],
        questions = {
            [1] = {
                question = "What is Your Name?",
                answers = {
                    {
                        id = 1,
                        answer = "Dora",
                        isCorrect = false
                    },
                    {
                        id = 2,
                        answer = "Dodo",
                        isCorrect = false
                    },
                    {
                        id = 3,
                        answer = "Alfred",
                        isCorrect = true
                    },
                    {
                        id = 4,
                        answer = "Kapoera",
                        isCorrect = false
                    },
                }
            },
            [2] = {
                question = "What is Your Gender?",
                answers = {
                    {
                        id = 1,
                        answer = "Male",
                        isCorrect = false
                    },
                    {
                        id = 2,
                        answer = "Female",
                        isCorrect = false
                    },
                    {
                        id = 3,
                        answer = "Basketball",
                        isCorrect = true
                    },
                    {
                        id = 4,
                        answer = "Kapoera",
                        isCorrect = false
                    },
                }
            },
        },
        prize = "phone",
        amount = 1,
        successPercent = 90,
        price = 50
    },
    ["LOL"] = {
        title = "Random Test",
        questions = {
            [1] = {
                question = "What is Your Name?",
                answers = {
                    {
                        id = 1,
                        answer = "Dora",
                        isCorrect = false
                    },
                    {
                        id = 2,
                        answer = "Dodo",
                        isCorrect = false
                    },
                    {
                        id = 3,
                        answer = "Alfred",
                        isCorrect = true
                    },
                    {
                        id = 4,
                        answer = "Kapoera",
                        isCorrect = false
                    },
                }
            },
            [2] = {
                question = "What is Your Gender?",
                answers = {
                    {
                        id = 1,
                        answer = "Male",
                        isCorrect = false
                    },
                    {
                        id = 2,
                        answer = "Female",
                        isCorrect = false
                    },
                    {
                        id = 3,
                        answer = "Basketball",
                        isCorrect = true
                    },
                    {
                        id = 4,
                        answer = "Kapoera",
                        isCorrect = false
                    },
                }
            },
        },
        prize = "phone",
        amount = 1,
        successPercent = 90,
        price = 90
    },
}
Config.Store = {
    location = vec3(244.061539, -1072.588989, 28.3),
    npc = "a_m_m_hasjew_01"
}

FrameworkObj = nil
if Config.Framework == "esx" then
    FrameworkObj = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb" then
    FrameworkObj = exports["qb-core"]:GetCoreObject()
else
    FrameworkObj = nil -- Change to your object
end
