const mongoose=require('mongoose')
const notificationschema=mongoose.Schema({
    // email:{
    //     type:String,
    //     required:true,
    //     match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/

    // },
    id:{
        type:String,
        
    },
    email:{
        type:String,
        
        match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/

    },
    notificationtext:{
        type:String,
        required:true
    },
    

});
module.exports=mongoose.model('notification',notificationschema);