const mongoose=require('mongoose')
const parcelassignmentschema=mongoose.Schema({
    parcelid:{
        type:String,
        unique:true,

    },
    fromemail:{
        type:String,
        match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/

    },
    toemail:{
        type:String,
        match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/ 
    },
    status:{
        type:String,
        
    }
});
module.exports=mongoose.model('parcelassignment',parcelassignmentschema);