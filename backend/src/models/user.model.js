import { mongoose } from 'mongoose';
const { Schema } = mongoose;

const userSchema = new Schema({
  fullName: {
    type: String,
    required: true
  },
  email: {
    type: String,
    unique: true,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  authType: {
    type: String,
    enum: ['jwt', 'oauth'],
    required: true,
  },
  role: {
    type: String,
    enum: ['admin', 'user'],
    default: "user",
  },
  profilePicture: {
    type: String,
  },
  createdAt: { 
    type: Date, 
    default: Date.now 
  },
  mentalHealthScore:{
    type:Number,
    default:0,
    max:10
  }
  
}, {
  timestamps: true
});

export default User = mongoose.model('User', userSchema);