var express = require('express');
var mongoose = require('mongoose');
var router = express.Router();
var parcel=require('../models/parcel');
var notification = require('../models/notification');
var user = require('../models/User');
var deliveryguy = require('../models/deliveryguy');
router.post('/', async (req, res, next) => {
    // print('parcel');
    // print(req.user);
    try{
    console.log('parcel')
    // console.log(req.user)
    const body = req.body;
    console.log(body)
    const newparcel=parcel(body);
    newparcel.save();
    console.log('newparcelid');
    console.log(newparcel._id);
    res.status(200).json({msg:'success',parcelid:newparcel._id})
    }
    catch(err){
        console.log('fail add ordrer');
        req.status(500).json({msg:err.msg})
    }
});
router.post('/map', async (req, res, next) => {
    // print('parcel');
    // print(req.user);
    console.log('map')
    console.log(req.body['id'])
  id=req.body['id']
//   id=id.substring(1, id.length-1);
//   console.log(objectId)
  notification.find({_id:id})
  .exec()
  .then(
    notificationdetails=>{
      console.log('notificationdetailssss')
      console.log(notificationdetails)
      user.find({ email: notificationdetails[0]['email'] })
      .exec()
      .then(
        userdetails=>{
        console.log(userdetails);
        parcel.find({sourceid:"{id: "+userdetails[0]['_id'].toString()+"}"})
        .exec()
        .then(
           parceldetails=>{
            res.status(200).send({ msg: parceldetails[0]['destinationaddress']});
           } 
        )
        })
    }
  )

});

router.post('/map2', async (req, res, next) => {
    // print('parcel');
    // print(req.user);
//   id=id.substring(1, id.length-1);
//   console.log(objectId)
deliveryguy.find({email:req.body.email})
  .exec()
  .then(
    deliverydetails=>{
        return res.status(200).json({msg:deliverydetails[0]['location']})
    }
  )

});

router.post('/map1', async (req, res, next) => {
    // print('parcel');
    // print(req.user);
    console.log('update')
    notification.find({_id:req.body.id})
    .exec()
    .then(
      notificationdetails=>{
        console.log('notificationdetailssss')
        console.log(notificationdetails)
        user.find({ email: notificationdetails[0]['email'] })
        .exec()
        .then(
          userdetails=>{
          console.log(userdetails);
          parcel.find({sourceid:"{id: "+userdetails[0]['_id'].toString()+"}"})
          .exec()
          .then(
             parceldetails=>{
              const existing = deliveryguy.findOne({ email: parceldetails[0]['deliveryemail'] });
          if (existing) {
            /** Set flash message and redirect to signup page */
            existing['location'] = req.body.location;
            existing.save()
            res.status(200).json({msg:'success'})
          }
          else{
              try{
                  // console.log(req.user)
                  const body = req.body;
                  console.log(body)
                  var temp = {'email':parceldetails[0]['deliveryemail'],
                  'location':req.body.location

                  }
                  const newdelivery=deliveryguy(temp);
                  newdelivery.save();
                  console.log('saved');
                  // console.log(newparcel._id);
                  res.status(200).json({msg:'success'})
                  }
                  catch(err){
                      console.log('fail add ordrer');
                      req.status(500).json({msg:err.msg})
                  }
          }
                  } 
                )
                })
      }
    )
    
    
    });
// router.get('/', async (req, res, next) => {
//     // print('parcel');
//     // print(req.user);
//     console.log('parcelget')
//     // console.log(req.user)
//     // const body = req.body;
//     // const newparcel=parcel(body);
//     // newparcel.save();
//     // res.status(200).json({msg:'success'})
// });
module.exports=router;