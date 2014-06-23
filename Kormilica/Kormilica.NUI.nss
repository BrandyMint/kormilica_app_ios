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
    separator-color: @primaryTableColor;
}

TableCellView {
    background-color: @primaryTableCellColor;
}

BarButton {
    background-color: #9ED5F5;
    corner-radius: 7;
    font-name: @secondaryFontNameBold;
    font-color: @navFontColor;
    font-size: 13;
    text-shadow-color: clear;
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
    border-color: @primaryTableColor;
    font-color: @primaryTableColor;
}

ButtonCategory {
    corner-radius: 5;
    font-name: @secondaryFontName;
    font-size: 14;
    text-align: center;
    text-auto-fit: false;
    border-width: 2;
    border-color: white;
}
ButtonCategorySelected {
    background-color: @primaryTableColor;
    font-color: white;
}
ButtonCategoryNoSelected {
    background-color: white;
    font-color: @primaryFontColor;
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
    font-color: @primaryTableColor;
    border-width: 1;
    border-color: @primaryTableColor;
}
TextViewDescriptionProduct {
    font-color: @primaryFontColor;
    font-name: @secondaryFontName;
    font-size: 16;
}

Label {
    font-name: @secondaryFontName;
    font-size: 14;
    font-color: @primaryFontColor;
    text-auto-fit: false;
}
TitleProductCell {
    font-size: 16;
}
PriceProductCell {
    font-color: @priceFontColor;
    font-size: 18;
}
AllSum {
    text-align: center;
    border-color: @primaryFontColor;
    border-width: 1;
}
OrderFill {
    text-align: center;
    font-color: black;
    background-color: @primaryFontColor;
}
OrderDeliver {
    text-align: center;
    font-color: white;
    background-color: #7ac943;
}
OrderSending {
    text-align: center;
    font-color: black;
    background-color: white;
}
OrderReturn {
    text-align: center;
    font-color: white;
    background-color: @primaryTableColor;
}
Telephone {
    font-size: 20;
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
    font-color: @navFontColor;
    text-shadow-color: clear;
    background-color-top: #54B4EB;
    background-color-bottom: #2FA4E7;
}
TabBar {
    background-color: #FFFFFF;
}
TabBarItem {
    font-name: @secondaryFontName;
    font-color: @primaryFontColor;
    font-size: 18;
    text-offset: 0,-11;
}

TextField {
    font-name: @inputFontName;
    font-size: 14;
    border-style: none;
    vertical-align: center;
}

ScrollView {
    background-color: white;
}
OrderAllowed {
    background-color: @primaryTableColor;
}
OrderNotAllowed {
    background-color: #e6e7e8;
}