import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { asyncHandler } from "../utils/asyncHandler.js";
import { Question } from "../models/question.model.js";

const addQuestion = asyncHandler(
  async (req, res, next) => {
    const { question, optionOne, optionTwo, optionThree, optionFour } = await req.body;
    let object = {}
    if(optionOne){
      object = {
        question,
        options: [
          optionOne,
          optionTwo,
          optionThree,
          optionFour
        ]
      }
    } else {
      object = {
        question
      }
    };

    const newQuestion = new Question({
      question
    });
    await newQuestion.save();

    if(!newQuestion){
      throw new ApiError(404, "Question not created")
    };

    return res.status(200)
    .json(
      new ApiResponse(
        200,
        {
          question: question
        },
        "Question Creatted Succesfully"
      )
    )
  }
)

export {
  addQuestion
}