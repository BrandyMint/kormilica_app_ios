@primaryFontName: ArialRoundedMTBold;
@secondaryFontName: ArialRoundedMTBold;
@secondaryFontNameBold: ArialRoundedMTBold;
@secondaryFontNameStrong: ArialRoundedMTBold;
@inputFontName: ArialRoundedMTBold;
@primaryFontColor: #666666;
@secondaryFontColor: #888888;
@navFontColor: #FFFFFF;
@primaryBackgroundColor: #E6E6E6;
@primaryBackgroundTintColor: #ECECEC;
@primaryBackgroundColorTop: #FFFFFF;
@primaryBackgroundColorBottom: #ECECEC;
@primaryBackgroundColorBottomStrong: #DDDDDD;
@secondaryBackgroundColorTop: #FFFFFF;
@secondaryBackgroundColorBottom: #F9F9F9;
@primaryBorderColor: #EEEEEE;
@primaryBorderWidth: 1;

@primaryTableColor: #9ED5F5;
@primaryTableCellColor: white;
@priceFontColor: red;

Table {
    separator-color: #d1d3d4;
}

TableCellView {
    background-color: @primaryTableCellColor;
}
ButtonOrderCell{
    background-color: white;
    border-width: 1;
    corner-radius: 5;
    font-name: @secondaryFontName;
    font-size: 14;
    text-align: center;
    text-auto-fit: false;
}
ButtonInOrder {
    border-color: #7ac943;
    font-color: #7ac943;
}
ButtonInNotOrder {
    border-color: #007aff;
    font-color: #007aff;
}
ButtonDelivery {
    border-color: black;
    font-color: black;
}

ButtonCategory {
    corner-radius: 5;
    font-name: @primaryFontName;
    font-size: 16;
    text-align: center;
    text-auto-fit: false;
    border-width: 2;
    border-color: #f8f8f8;
}
ButtonCategorySelected {
    background-color: #007aff;
    font-color: white;
}
ButtonCategoryNoSelected {
    background-color: #f8f8f8;
    font-color: #007aff;
}

ButtonAddToCart {
    corner-radius: 5;
    font-name: @secondaryFontName;
    font-size: 16;
    text-align: center;
    text-auto-fit: false;
    border-width: 0;
}
ButtonAddToCartSelected {
    background-color: #7ac943;
    font-color: white;
}

ButtonAddToCartUnSelected {
    background-color: white;
    font-color: #007aff;
    border-width: 1;
    border-color: #007aff;
}
TextViewDescriptionProduct {
    font-color: @primaryFontColor;
    font-name: @primaryFontName;
    font-size: 14;
}
ButtonLastUpdate {
    font-name: @secondaryFontName;
    font-size: 14;
    font-color: @primaryFontColor;
}

Label {
    font-name: @secondaryFontName;
    font-size: 14;
    font-color: @primaryFontColor;
    text-auto-fit: false;
}
NameCompany {
    font-name: @primaryFontName;
    font-size: 18;
    font-color: black;
}
WhiteText {
    font-name: @primaryFontName;
    font-size: 16;
    font-color: white;
}
TitleProductCell {
    font-size: 16;
}
PriceProductCell {
    font-size: 16;
}
AllSum {
    text-align: center;
    border-color: @primaryFontColor;
    border-width: 1;
}
OrderFill {
    font-name: @primaryFontName;
    text-align: center;
    font-color: #6c6d6d;
    background-color: #d1d3d4;
}
OrderDeliver {
    font-name: @primaryFontName;
    text-align: center;
    font-color: white;
    background-color: #7ac943;
}
OrderSending {
    font-name: @primaryFontName;
    text-align: center;
    font-color: black;
    background-color: white;
}
OrderReturn {
    font-name: @primaryFontName;
    text-align: center;
    font-color: white;
    background-color: #007aff;
}
Telephone {
    font-size: 20;
}
OrderInfo {
    font-size: 10;
}
OrderSending {
    font-color: white;
    background-color: #7ac943;
}
OrderFailSending {
    font-color: white;
    background-color: red;
}

NavigationBar {
    font-name: @secondaryFontName;
    font-size: 20;
    font-color: black;
    text-shadow-color: clear;
}
TabBar {
    background-color: #FFFFFF;
}
TabBarItem {
    font-name: @secondaryFontName;
    font-color: red;
    font-size: 18;
    text-offset: 0,-11;
}
BarButton {
    #background-color: #9ED5F5;
    #corner-radius: 7;
    #font-name: @secondaryFontNameBold;
    #font-color: @navFontColor;
    #font-size: 13;
    #text-shadow-color: clear;
}
TextField {
    font-name: @primaryFontName;
    font-size: 16;
    font-color: #d1d3d4;
    border-style: none;
    vertical-align: center;
}
TextFieldActive {
    font-color: black;
}
TextFieldCity {
    font-color: 007aff;
}

ScrollView {
    background-color: #f8f8f8;
}
OrderAllowed {
    background-color: #007aff;
}
OrderNotAllowed {
    background-color: #d1d3d4;
}