import easypost
easypost.api_key = 'EZAK0469e54dac3747da9cc7cc4f7a6c4a1dJPanR7b5h8g9LYaGnsRiww'

# create and verify addresses
to_address = easypost.Address.create(
    verify=["delivery"],
    zip = "90277"
    '''
    name = "Dr. Steve Brule",
    street1 = "179 N Harbor Dr",
    street2 = "",
    city = "Redondo Beach",
    state = "CA",
    country = "US",
    phone = "310-808-5243",
    '''
)
from_address = easypost.Address.create(
    verify=["delivery"],
    zip = "94105"
    '''
    name = "EasyPost",
    street1 = "118 2nd Street",
    street2 = "4th Floor",
    city = "San Francisco",
    state = "CA",
    country = "US",
    phone = "415-456-7890",
    '''
)

# create parcel
try:
    parcel = easypost.Parcel.create(
        predefined_package = "Parcel",
        weight = 21.2
    )
except easypost.Error as e:
    print(str(e))
    if e.param is not None:
        print('Specifically an invalid param: %r' % e.param)

parcel = easypost.Parcel.create(
    length = 10.2,
    width = 7.8,
    height = 4.3,
    weight = 21.2
)

# create customs_info form for intl shipping
customs_item = easypost.CustomsItem.create(
    description = "EasyPost t-shirts",
    hs_tariff_number = 123456,
    origin_country = "US",
    quantity = 2,
    value = 96.27,
    weight = 21.1
)
customs_info = easypost.CustomsInfo.create(
    customs_certify = 1,
    customs_signer = "Hector Hammerfall",
    contents_type = "gift",
    contents_explanation = "",
    eel_pfc = "NOEEI 30.37(a)",
    non_delivery_option = "return",
    restriction_type = "none",
    restriction_comments = "",
    customs_items = [customs_item]
)

# create shipment
shipment = easypost.Shipment.create(
    to_address = to_address,
    from_address = from_address,
    parcel = parcel,
    customs_info = customs_info
)

# buy postage label with one of the rate objects
#shipment.buy(rate = shipment.rates[0])
shipment.buy(rate = shipment.lowest_rate())

print(shipment.tracking_code)
print(shipment.postage_label.label_url)

# Insure the shipment for the value
shipment.insure(amount=100)

print(shipment.insurance)
