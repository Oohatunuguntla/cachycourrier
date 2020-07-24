const mongoose=require('mongoose')
const deliveryguyschema=mongoose.Schema({
    
   
    email:{
        type:String,
        required:true,
        unique:true,
        match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/

    },
    location:{
        type:String,
        required:true

    },
   
});
module.exports=mongoose.model('deliveryguy',deliveryguyschema);