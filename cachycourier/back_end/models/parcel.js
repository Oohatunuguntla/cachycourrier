const mongoose=require('mongoose')
const parcelschema=mongoose.Schema({
    sourceid:{
        type:String,
    },
    timetopick:{
        type:String,
       
    },
    year:{
        type:String,
    },
    month:{
        type:String,
    },
    day:{
        type:String,
    },
    weight:{
        type:String,
        
    },
    sourceaddress:{
        type:String,
      
    },
    destinationaddress:{
        type:String,
       
    },
    parceltype:{
        type:String,
        
    },
    status:{
        type:String,
    },
    cost:{
        type:String,
       
    },
    promocode:{
        type:String,
    },
    deliveryemail:{
        
            type:String,
            required:true,
            
            match:/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/
    
        
    },
    ispaid:{
                type:String
                
            },

});
module.exports=mongoose.model('parcel',parcelschema);