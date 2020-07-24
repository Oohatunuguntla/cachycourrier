var express = require('express');
var router = express.Router();
const bcrypt = require('bcryptjs');
const parcelassignment=require('../models/parcelassignment');
const parcel=require('../models/parcel');
const user = require('../models/User');
router.get("/statsofapp", (req, res,next) => {
    try{
  console.log('statsofapp');
  parcel.countDocuments({status:'created_but_not_assigned'},function(err,created_but_not_assigned)
  
  {
    if(err){
        console.log(err);
        
    }
    else{
        console.log(created_but_not_assigned);
        parcel.countDocuments({status:'ongoing'},function(error,ongoing)
        {
            if(error){
                console.log(error)
            }
            else{
                console.log(ongoing)
                parcel.countDocuments({status:'completed'},function(erro,completed)
                {
                    if(erro){
                        console.log(erro)
                    }
                    else{
                        console.log(completed);
                        res.status(200).json({created_but_not_assigned:created_but_not_assigned,ongoing:ongoing,completed:completed})
                    }
                })
            }
        })
    }
  })}
  catch(error){
      console.log(error)
      res.status(500).json({msg:error})
  }
    //     parcel.countDocuments({status:'created but not assigned'})
    //     .exec()
    //     .then(
    //         orders_created_not_assigned=>{
    //             console.log(orders_created_not_assigned);
    //         },
    //         parcel.countDocuments({status:'ongoing'})
    //         .exec()
    //         .then(
    //             orders_ongoing=>{
    //                 console.log(orders_ongoing);
    //             },

    //         parcel.countDocuments({status:'completed'})
    //             .exec()
    //             .then(
    //                 orders_completed=>{
    //                     console.log(orders_completed);
    //                 },
                    
    //             )
    //         )

    //     )
       
    //    res.status(200).json({orders_created_not_assigned:orders_created_not_assigned,orders_ongoing:orders_ongoing,orders_completed:orders_completed})
       
   
});


router.get("/statsofapp", (req, res,next) => {
    try{
  console.log('statsofapp');
  parcel.countDocuments({status:'created_but_not_assigned'},function(err,created_but_not_assigned)
  
  {
    if(err){
        console.log(err);
        
    }
    else{
        console.log(created_but_not_assigned);
        parcel.countDocuments({status:'ongoing'},function(error,ongoing)
        {
            if(error){
                console.log(error)
            }
            else{
                console.log(ongoing)
                parcel.countDocuments({status:'completed'},function(erro,completed)
                {
                    if(erro){
                        console.log(erro)
                    }
                    else{
                        console.log(completed);
                        res.status(200).json({created_but_not_assigned:created_but_not_assigned,ongoing:ongoing,completed:completed})
                    }
                })
            }
        })
    }
  })}
  catch(error){
      console.log(error)
      res.status(500).json({msg:error})
  }
    //     parcel.countDocuments({status:'created but not assigned'})
    //     .exec()
    //     .then(
    //         orders_created_not_assigned=>{
    //             console.log(orders_created_not_assigned);
    //         },
    //         parcel.countDocuments({status:'ongoing'})
    //         .exec()
    //         .then(
    //             orders_ongoing=>{
    //                 console.log(orders_ongoing);
    //             },

    //         parcel.countDocuments({status:'completed'})
    //             .exec()
    //             .then(
    //                 orders_completed=>{
    //                     console.log(orders_completed);
    //                 },
                    
    //             )
    //         )

    //     )
       
    //    res.status(200).json({orders_created_not_assigned:orders_created_not_assigned,orders_ongoing:orders_ongoing,orders_completed:orders_completed})
       
   
});

router.get('/statsofdeliveryguy', async (req, res, next) => {
    //required current loginid
    console.log(req.query['id'])
    id=req.query['id']
    id=id.substring(1, id.length-1);
    var objectId = mongoose.Types.ObjectId(id);
    // var decoded=decodeURIComponent(req.url)
    var decoded=querystring.parse(req.url)
    // console.log(decoded['id'])
  
    //List parts = req.url.Split(new char[] {'?','&'});
    parcelassignment.find({_id:objectId})
    .exec()
    .then(
      userdetails=>{
        console.log('userdetailssss')
        console.log(userdetails)
        
        // notification.find({ email: userdetails[0]['email'] })
        // .exec()
        // .then(
        //   notificationss=>{
        //   console.log(notificationss);
        //   res.status(200).send({ notification: notificationss });
        //   })
      }
    )
  
  });

router.get('/', async (req, res, next) => {
    console.log('statistiics url')
    console.log(req.url)
    var decoded=decodeURIComponent(req.url)
    console.log(decoded)
    //List parts = req.url.Split(new char[] {'?','&'});
    email='tunuguntlaooha1234@gmail.com'
    user.find({ email: email })
    const userdetails=await user.findOne({email:email});
    console.log(userdetails['type'])
    if(userdetails['type']=='deliveryguy')
    {
        parcelassignment.find({toemail:email})
        .exec()
        .then(
            parcelassignmentdetails=>{
                console.log(len(parcelassignmentdetails))

                res.status(200).send({statitics:parcelassignmentdetails});
            }
        )
    }
    else if (userdetails['type']=='customer') {
        console.log('finding in database')
        parcelassignment.find({fromemail:email})
        .exec()
        .then(
            parcelassignmentdetails=>{
                console.log(parcelassignmentdetails[0])
                res.status(200).send({statitics:parcelassignmentdetails});
            }
        )
        
    }
    
    //   .exec()
    //   .then(
    //     userdetails=>{
    //     if(userdetails)
    //     res.status(200).send({ statistics: statistics });
    //     })
  
  });
  module.exports=router;