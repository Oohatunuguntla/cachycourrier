const mongoose=require('mongoose')
const deliveryguyschema=mongoose.Schema({
    
   
    email:{
        type:String,
        required:true,
        unique:true,
        match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/

    },
    id:{
        type:String,
        required:true,
        unique:true

    },
    assigned: { type: Boolean, default: false },
    
   


});
module.exports=mongoose.model('deliveryguy',deliveryguyschema);