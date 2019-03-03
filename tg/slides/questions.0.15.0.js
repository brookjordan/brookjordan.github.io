'use strict';

var initialQuestion = 'question01';
var failureQuestion = 'question18';
var failureQuestions = ['question02', 'question18'];
var maxNoCount = 8;
var winCount = 5;

var questions = {

  question01: {
    text: 'Do you sell inventory?',
    yes: 'question03',
    no: 'question02'
  },

  question02: {
    text: 'Oh ok.. then we can confidently say with all our expertise you definitely don\'t need inventory management. Good thing you came to the experts to find out.'
  },

  question03: {
    text: 'Are you using a spreadsheet to track stock levels?',
    yes: 'question04',
    no: 'question04',
    subtext: 'Keeping track of inventory on Excel can result in errors, but with TradeGecko stock levels are kept up to date across all your sales channels.'
  },

  question04: {
    text: 'Do you sell in multiple locations?',
    yes: 'question05',
    no: 'question05',
    subtext: 'TradeGecko handles order management across multiple currencies and languages!'
  },

  question05: {
    text: 'Do you keep stock in multiple locations?',
    yes: 'question06',
    no: 'question06',
    subtext: 'Managing stock gets a lot harder with multiple warehouses, TradeGecko takes care of this as well.'
  },

  question06: {
    text: 'Do you have 2 or more people responsible for selling stock?',
    yes: 'question07',
    no: 'question07',
    subtext: 'TradeGecko includes detailed user permissions so you can assign unique roles to each team member.'
  },

  question07: {
    text: 'Do you use multiple online services like Xero, Shopify, QuickBooks, Amazon etc?',
    yes: 'question08',
    no: 'question08',
    subtext: 'We integrate seamlessly with all the best online tools for eCommerce, accounting and shipping.'
  },

  question08: {
    text: 'Do you want to sell wholesale online?',
    yes: 'question09',
    no: 'question09',
    subtext: 'TradeGecko gives you a customizable B2B eCommerce Store that is unique for each of your customers\' catalogs, price lists and discounts.'
  },

  question09: {
    text: 'Do you sell perishable goods?',
    yes: 'question10',
    no: 'question10',
    subtext: 'TradeGecko includes complete support for batches, pack sizes and expiry dates.'
  },

  question10: {
    text: 'Do you run into problems predicting sales trends or knowing exact profit margins?',
    yes: 'question11',
    no: 'question11',
    subtext: 'With our detailed reporting and customer insights you can review all your business data and predict trends as you grow.'
  },

  question11: {
    text: 'Do you want to find new ways to sell? (New markets and channels)',
    yes: 'question12',
    no: 'question12',
    subtext: 'Organising all your sales channels together in one place makes it much easier to spend time on new opportunities.'
  },

  question12: {
    text: 'Do you spend more than 2 hours per week managing inventory?',
    yes: 'question13',
    no: 'question13',
    subtext: 'If you spend too long on the operations of running a business then you\'re not doing what you dreamt of when you started out.'
  },

  question13: {
    text: 'Do you ever sell offline?',
    yes: 'question14',
    no: 'question14',
    subtext: 'With the TradeGecko mobile app you can create and edit orders from anywhere, so no more manual order writing at trade shows or sales calls.'
  },

  question14: {
    text: 'Do you manually create Purchase orders?',
    yes: 'question15',
    no: 'question15',
    subtext: 'With TradeGecko it\'s super easy to automate reorder points and backordering for purchasing stock.'
  },

  question15: {
    text: 'Do you want a cohesive CRM system that ties orders to relationships?',
    yes: 'question16',
    no: 'question16',
    subtext: 'Our detailed CRM across web and mobile keeps you close to your customers and suppliers.'
  },

  question16: {
    text: 'Have you ever run out of toilet paper?',
    yes: 'question17',
    no: 'question17',
    subtext: 'Don\'t sweat, you can buy it online now! (something funnier)'
  },

  question17: {
    text: 'Looks like you could really benefit from TradeGecko inventory and order management!',
    ctaURL: 'https://www.google.com/',
    ctaText: 'Start a free trial',
    subtext: 'The trial is free, no obligation and lasts 14 days to help you see how we can help you with this and more!'
  },

  question18: {
    text: 'Looks like you don\'t really need inventory management yet, but we have an Excel spreadsheet that may do the job for now.',
    ctaURL: 'https://www.google.com/',
    ctaText: 'Download the spreadsheet',
    subtext: 'This spreadsheet can help you with this and that and more, wow, you can\'t get better than that!'
  }

};