var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');
const parcelassignment=require('../models/parcelassignment');
const parcel=require('../models/parcel');
const user = require('../models/User');
const bcrypt = require('bcryptjs');
const notification=require('../models/notification');
const querystring = require('querystring');
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

router.get('/statsofdeliveryguy',(req,res,next)=>{
try{
    id=req.query['id']
  id=id.substring(1, id.length-1);
  var objectId = mongoose.Types.ObjectId(id);
  // var decoded=decodeURIComponent(req.url)
  var decoded=querystring.parse(req.url)
  // console.log(decoded['id'])

  //List parts = req.url.Split(new char[] {'?','&'});
  user.find({_id:objectId})
  .exec()
  .then(
    userdetails=>{
      console.log('userdetailssss')
      console.log(userdetails)
      //userdetails[0]['email']
      //
      parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'1'},function(err,january){
          if(err){
              console.log(err);
          }
        else{
            console.log(january);
            parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'2'},function(err,febraury){
            if(err){
                console.log(err);
            }
            else{
                parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'3'},function(err,march){
                    if(err){
                        console.log(err)
                    }
                    else{
                        parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'4'},function(err,april){
                            if(err){
                                console.log(err)
                            }
                            else{
                                parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'5'},function(err,may){
                                    if(err){
                                        console.log(err)
                                    }
                                    else{
                                        parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'6'},function(err,june){
                                            if(err){
                                                  console.log(err)  
                                            }
                                            else{
                                                parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'7'},function(err,july){
                                                    if(err){
                                                        console.log(err)
                                                    }
                                                    else{
                                                        parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'8'},function(err,august){
                                                            if(err){
                                                                console.log(err)
                                                            }
                                                            else{
                                                                parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'9'},function(err,september){
                                                                    if(err){
                                                                        console.log(err)
                                                                    }
                                                                    else{
                                                                        parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'10'},function(err,october){
                                                                            if(err){
                                                                                console.log(err)
                                                                            }
                                                                            else{
                                                                                parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'11'},function(err,november){
                                                                                    if(err){
                                                                                        console.log(err)
                                                                                    }
                                                                                    else{
                                                                                        parcel.countDocuments({ deliveryemail: 'saisreenithya@gmail.com',year:'2020',month:'12'},function(err,december){
                                                                                            if(err){
                                                                                                console.log(err)
                                                                                            }
                                                                                            else{
                                                                                               res.status(200).json({januray:january,febraury:febraury,march:march,april:april,may:may,
                                                                                                                   june:june,july:july,august:august,september:september,october:october,
                                                                                                                    november:november,december:december
                                                                                            
                                                                                            })
                                                                                            }
                                                                                            })
                                                                                    }
                                                                                    })
                                                                            }
                                                                            })
                                                                    }
                                                                    })
                                                                
                                                            }
                                                            })
                                                    }
                                                    })
                                            }
                                            })
                                    }
                                    }) 
                            }
                            })
                    }
                    })
            }
            })
        }
      })
      
    })
}
catch(error){
    console.log(error)
      res.status(500).json({msg:error})
}
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

// router.get('/statsofdeliveryguy', async (req, res, next) => {
//     //required current loginid
//     console.log(req.query['id'])
//     id=req.query['id']
//     id=id.substring(1, id.length-1);
//     var objectId = mongoose.Types.ObjectId(id);
//     // var decoded=decodeURIComponent(req.url)
//     var decoded=querystring.parse(req.url)
//     // console.log(decoded['id'])
  
//     //List parts = req.url.Split(new char[] {'?','&'});
//     parcelassignment.find({_id:objectId})
//     .exec()
//     .then(
//       userdetails=>{
//         console.log('userdetailssss')
//         console.log(userdetails)
        
//         // notification.find({ email: userdetails[0]['email'] })
//         // .exec()
//         // .then(
//         //   notificationss=>{
//         //   console.log(notificationss);
//         //   res.status(200).send({ notification: notificationss });
//         //   })
//       }
//     )
  
//   });

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