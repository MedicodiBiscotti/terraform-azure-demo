terraform {
  cloud {
    organization = "Exam-Project-SWD"

    workspaces {
      name = "test"
    }
  }
}