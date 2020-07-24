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
    ispaid:{
                type:Boolean,
                
            },

});
module.exports=mongoose.model('parcel',parcelschema);