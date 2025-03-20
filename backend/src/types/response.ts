export interface Response{
  userId:string;
  storyId:string;
  responses:[
    {
      questionId:string;
      answer:string;
    }
  ];
}