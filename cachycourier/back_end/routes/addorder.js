var express = require('express');
var router = express.Router();
var parcel=require('../models/parcel')
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