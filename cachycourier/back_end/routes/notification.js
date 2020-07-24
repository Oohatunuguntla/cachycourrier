var express = require('express');
var mongoose = require('mongoose');
var router = express.Router();
const bcrypt = require('bcryptjs');
const notification=require('../models/notification');
const querystring = require('querystring');
var parcel=require('../models/parcel');
var user=require('../models/User');
var nodemailer = require('nodemailer');
var transporter = nodemailer.createTransport({ service: "gmail", auth: { user: 'oohas1234@gmail.com', pass: '9840290558' } });
router.get('/', async (req, res, next) => {
  console.log(req.query['id'])
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
      notification.find({ email: userdetails[0]['email'] })
      .exec()
      .then(
        notificationss=>{
        console.log(notificationss);
        res.status(200).send({ notification: notificationss });
        })
    }
  )

});
router.post('/sendnotification', async function(req,res,next){
  var parcelid=req.body['parcelid'];
  parcel.find({_id:parcelid})
  .exec()
  .then(
    parceldetails1=>{
     console.log('parceldetailss')
      parceldetails=JSON.parse(JSON.stringify(parceldetails1));
      console.log(parceldetails)
      var id=parceldetails[0]['_id']
      var sourceaddress=parceldetails[0]['sourceaddress']
      var destinationaddress=parceldetails[0]['destinationaddress']
      var parceltype=parceldetails[0]['parceltype']
      var cost=parceldetails[0]['cost']
      var ispaid=parceldetails[0]['ispaid']
      const link = `http://${process.env.ipadress}:${process.env.port}`
      
      var deliveryemail='tunuguntlaooha1234@gmail.com'
      var deliveryguymobilenumber='9840290558'
      if(ispaid) {
        
        const sendnotificationtodeliveryguy = {
        to: deliveryemail,
        from: 'oohas1234@gmail.com',
        subject: 'Cachy_courrier delivery assignment',
        //html: `Hello,<br> Please Click on the link to verify your email.<br><a href="${link}">${link}</a>`,
        html:`Hello ${deliveryemail},<br>You are assigned to parcelid ${id} and details are as follows:<br>
        sourceaddress:${sourceaddress}<br>
        destinationaddress:${destinationaddress}<br>
        parceltype:${parceltype}<br>
        Payment is already done
         `
        
      }
      transporter.sendMail(sendnotificationtodeliveryguy,async function (err) {
        if (err) {
          console.log("didnot send email to  delivery guy assignment");
          res.status(500).send({ msg: err.message });
        }
        else{
          newnotify={'email':sendnotificationtodeliveryguy['to'],'notificationtext':sendnotificationtodeliveryguy['html']}
          const newnotification=new notification(newnotify)
          console.log(newnotification)
          await newnotification.save()
        }
      });
      
    }
    else{
      
        const sendnotificationtodeliveryguy = {
        to: deliveryemail,
        from: 'oohas1234@gmail.com',
        subject: 'Cachy_courrier delivery assignment',
        //html: `Hello,<br> Please Click on the link to verify your email.<br><a href="${link}">${link}</a>`,
        html:`Hello ${deliveryemail},<br>You are assigned to parcelid ${id} and details are as follows:<br>
        sourceaddress:${sourceaddress}<br>
        destinationaddress:${destinationaddress}<br>
        parceltype:${parceltype}<br>
        payment:Cash on delivery<br>
        cost:${cost}<br>
        Please Click on the link to know route of customer .<br><a href="${link}">route</a>
      ` 
      }
      transporter.sendMail(sendnotificationtodeliveryguy, async function (err) {
        
        if (err) {
          console.log("didnot send email to delivery guy assignment");
          res.status(500).send({ msg: err.message });
        }
        else{
          newnotify={'email':sendnotificationtodeliveryguy['to'],'notificationtext':sendnotificationtodeliveryguy['html']}
          const newnotification=new notification(newnotify)
          console.log(newnotification)
          await newnotification.save()
        }
        
      });
    }
    console.log('sourceidd')
    sourceid=parceldetails[0]['sourceid'].split(":")[1].slice(1,-1);
    console.log(sourceid)
    var objectId = mongoose.Types.ObjectId(sourceid);
    user.find({_id:objectId})
    .exec()
    .then(
      userdetails=>{
        console.log(userdetails)
        var sourceemail=userdetails[0]['email']
        console.log('sourceemail')
        console.log(sourceemail)
        const sendnotificationtocustomer = {
          to: sourceemail,
          from: 'oohas1234@gmail.com',
          subject: 'Cachy_courrier parcel',
          //html: `Hello,<br> Please Click on the link to verify your email.<br><a href="${link}">${link}</a>`,
          html:`Hello ${sourceemail},<br>Your parcelid ${id} is assigned to ${deliveryemail} and contact his mobilenumber:${deliveryguymobilenumber} for urgent queries<br>
          Please Click on the link to track path of your courrier .<br><a href="${link}">${link}</a>`
        }
        transporter.sendMail(sendnotificationtocustomer,async function (err) {
          if (err) {
            console.log("didnot send email to  customer");
            res.status(500).send({ msg: err.message });
          }
          else{
            newnotify={'email':sendnotificationtocustomer['to'],'notificationtext':sendnotificationtocustomer['html']}
            const newnotification=new notification(newnotify)
            console.log(newnotification)
            await newnotification.save()
          }
        });
      }
    )

    
    }
  )
});
//   )
//   deliveryemail="venkat9989383223@gmail.com"
//   sourceemail="oohas1234@gmail.com"
//   //
//   const deliveryguydetails=await user.findOne({email:deliveryemail});
//   deliveryguymobilenumber=deliveryguydetails['mobilenumber'];
//   //
//   const parceldetails = await parcel.findOne({ id:'1' });
//   id=parceldetails['id']
//   sourceaddress=parceldetails['sourceaddress']
//   destinationaddress=parceldetails['destinationaddress']
//   parceltype=parceldetails['parceltype']
//   cost=parceldetails['cost']
//   //
//   const paymentdetails=await payment.findOne({id:id});
//   ispaid=paymentdetails['ispaid']
//   const link = `http://${process.env.ipadress}:${process.env.port}`
//  if(ispaid) {
//     const sendnotificationtodeliveryguy = {
//     to: deliveryemail,
//     from: 'oohas1234@gmail.com',
//     subject: 'Cachy_courrier delivery assignment',
//     //html: `Hello,<br> Please Click on the link to verify your email.<br><a href="${link}">${link}</a>`,
//     html:`Hello ${deliveryemail},<br>You are assigned to parcelid ${id} and details are as follows:<br>
//     sourceaddress:${sourceaddress}<br>
//     destinationaddress:${destinationaddress}<br>
//     parceltype:${parceltype}<br>
//     Payment is already done
//      `
    
//   }
//   transporter.sendMail(sendnotificationtodeliveryguy,async function (err) {
//     if (err) {
//       console.log("didnot send email to  delivery guy assignment");
//       res.status(500).send({ msg: err.message });
//     }
//     else{
//       newnotify={'email':sendnotificationtodeliveryguy['to'],'notificationtext':sendnotificationtodeliveryguy['html']}
//       const newnotification=new notification(newnotify)
//       console.log(newnotification)
//       await newnotification.save()
//     }
//   });
  
// }
// else{
  
//     const sendnotificationtodeliveryguy = {
//     to: deliveryemail,
//     from: 'tunuguntlaooha1234@gmail.com',
//     subject: 'Cachy_courrier delivery assignment',
//     //html: `Hello,<br> Please Click on the link to verify your email.<br><a href="${link}">${link}</a>`,
//     html:`Hello ${deliveryemail},<br>You are assigned to parcelid ${id} and details are as follows:<br>
//     sourceaddress:${sourceaddress}<br>
//     destinationaddress:${destinationaddress}<br>
//     parceltype:${parceltype}<br>
//     payment:Cash on delivery<br>
//     cost:${cost}<br>
//     Please Click on the link to know route of customer .<br><a href="${link}">route</a>
//   ` 
//   }
//   transporter.sendMail(sendnotificationtodeliveryguy, async function (err) {
    
//     if (err) {
//       console.log("didnot send email to delivery guy assignment");
//       res.status(500).send({ msg: err.message });
//     }
//     else{
//       newnotify={'email':sendnotificationtodeliveryguy['to'],'notificationtext':sendnotificationtodeliveryguy['html']}
//       const newnotification=new notification(newnotify)
//       console.log(newnotification)
//       await newnotification.save()
//     }
    
//   });
// }
// const sendnotificationtocustomer = {
//   to: sourceemail,
//   from: 'tunuguntlaooha1234@gmail.com',
//   subject: 'Cachy_courrier parcel',
//   //html: `Hello,<br> Please Click on the link to verify your email.<br><a href="${link}">${link}</a>`,
//   html:`Hello ${sourceemail},<br>Your parcelid ${id} is assigned to ${deliveryemail} and contact his mobilenumber:${deliveryguymobilenumber} for urgent queries<br>
//   Please Click on the link to track path of your courrier .<br><a href="${link}">${link}</a>`
// }
// transporter.sendMail(sendnotificationtocustomer,async function (err) {
//   if (err) {
//     console.log("didnot send email to  customer");
//     res.status(500).send({ msg: err.message });
//   }
//   else{
//     newnotify={'email':sendnotificationtocustomer['to'],'notificationtext':sendnotificationtocustomer['html']}
//     const newnotification=new notification(newnotify)
//     console.log(newnotification)
//     await newnotification.save()
//   }
// });

// });
      
    


module.exports = router;