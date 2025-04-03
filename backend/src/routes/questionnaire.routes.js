import { Router } from "express";
import { addQuestionnaire, getAllQuestionnaires , getOneQuestionnaire } from "../controller/questionnaire.controller.js";

const router = Router();

router.route("/add").post(
  addQuestionnaire
);

router.route("/get/:id").get(
  getOneQuestionnaire
)
router.route("/all").get(
  getAllQuestionnaires
)

export default router;