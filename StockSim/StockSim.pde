import yahoofinance.Stock; //<>//
import yahoofinance.YahooFinance;

import controlP5.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Map;

ControlP5 cp5;
List<Map<String, Stock>> recentPopularStocks;
String[] popularTickers = {"NDAQ", "^W5000", "^GSPC", "IBM", "GOOG", "FB", "AAPL", "AMZN", "MSFT", "INTC"};
List<Stock> recentQuotes;
int nextPull;
int nextPull2;
List<HistoricalQuote> stockHistQuotes;
String livePullStock;
String selectedStock;
int graphMode; // 0 - History, 1 - nonPopular Live, 2 - popularLive
boolean backgroundPulling;
boolean introScreen;



void setup() {
  size(1200, 600);
  surface.setTitle("Stock Grapher");
  background(256, 256, 256);
  recentQuotes = new ArrayList<Stock>();
  recentPopularStocks = new ArrayList<Map<String, Stock>>();
  stockHistQuotes = getPastYears("NDAQ", 1);
  livePullStock = "^GSPC";
  selectedStock = "^GSPC";
  backgroundPulling = false;
  introScreen = true;
  cp5 = new ControlP5(this)
    .setColorBackground(0xFF000000)   // colors are 0xFF + hex code
    .setColorForeground(0xFFDDDDDD )
    .setColorActive( 0xFFAAAAAA)
    ;
  graphMode = 0;
  setupMostPopularBar(10, 40);
  setupGraphPastRangeButtons(10, 70);
  setupGraphNewHistoryButtons(10, 70);
  hideGraphPastRangeButtons();
  hideGraphNewHistoryButtons();
  setupGraphModeButtons();
  setupIntroScreenButtons();
  // showButtonBars();
}

void draw() {

  if (introScreen) {
    textSize(73);
    fill(0);
    text("Welcome to Stock Grapher!", 100, 100);
     textSize(21);
     text("If your internet is slow, click \"start pulling later\" ",350,200);
  } else {
    background(256, 256, 256);  
    if (backgroundPulling) {
      livePullPopular(popularTickers, 3000);  // should always be on
      livePull(livePullStock, 3000);
    }
    if (graphMode == 0) {
      graphEntireList(stockHistQuotes, 800, 400, 100, 550, cp5.get(Toggle.class, "historyMouseTracking").getBooleanValue());
    } else if (graphMode == 1) {
      if (cp5.get(Toggle.class, "liveGraphEntireList").getBooleanValue()) {
        graphEntireListStock(recentQuotes, 800, 400, 100, 550);
      } else {
        graphRange(recentQuotes, 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
      }
    } else if (graphMode == 2) {
      graphRangePopular(recentPopularStocks, selectedStock, 800, 400, 100, 550, (int) cp5.getController("pastRangeNumber").getValue());
    }
  }
}