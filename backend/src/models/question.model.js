import { Schema, models, model } from "mongoose";

const questionSchema = new Schema({
  question: {
    type: String,
    required: true
  },
  options: {
    type: {
      optionOne: {
        type: String
      },
      optionTwo: {
        type: String
      },
      optionThree: {
        type: String
      },
      optionFour: {
        type: String
      }
    }
  }
});

export const Question = model("Question" , questionSchema);