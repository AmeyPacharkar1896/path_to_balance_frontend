import { Router } from "express";
import { login, signup , logout } from "../controller/user.controller.js";
import { upload } from "../middlewares/multer.middleware.js";

const router = Router();
router.route('/signup').post(
  upload.fields([
    {
      name: 'avatar',
      maxCount: 1,
    }
  ]),
  signup,
);

router.route('/login').post(
  login,
);


router.route('/logout').post(
  logout,
);

export default router;