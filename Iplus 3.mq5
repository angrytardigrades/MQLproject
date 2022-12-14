//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"

input int q=1;
input int typeofanalysis=2;
input int nOfCandleW=15;
int MaxTPSLCalc=20;
int MinLimit2=100;
int MinRateB=2;
int MinRateM=2;
int MinRateS=2;
int MinRateSP=2;
int k=q;
double TL2;
double LL2;
double TL;
double LL;
int countpush2=0;
int countpush1=0;
int NoCloseU=0;
int NoCloseD=0;
bool Break1StatusT=0;
bool Break1StatusL=0;
bool Break2StatusT=0;
bool Break2StatusL=0;
int priceposition;
string pp;
string sym=Symbol();
string candletype;
int candlesize;
double minTL2=TL+((TL-LL)*2);
double minLL2=LL-((TL-LL)*2);
string accountname=AccountInfoString(ACCOUNT_NAME);
long accountnumber=AccountInfoInteger(ACCOUNT_LOGIN);
//bool demo=IsDemo();
string democode;
double equity=AccountInfoDouble(ACCOUNT_EQUITY);
double balance=AccountInfoDouble(ACCOUNT_BALANCE);
string server=AccountInfoString(ACCOUNT_SERVER);
string company=AccountInfoString(ACCOUNT_COMPANY);
double profit=AccountInfoDouble(ACCOUNT_PROFIT);
double credit=AccountInfoDouble(ACCOUNT_CREDIT);
//bool marketopenclose=MarketInfo(Symbol(), MODE_TRADEALLOWED);
double Firstinline=LL+((TL-LL)/3);
double Secondinline=LL+(2*(TL-LL)/3);

input int nOfCandleWmonthly=12;
int MaxTPSLCalcmonthly=20;
int MinLimit2monthly=200;
int MinRateBmonthly=2;
int MinRateMmonthly=2;
int MinRateSmonthly=2;
int MinRateSPmonthly=2;
double TL2monthly;
double TL2Smonthly;
double LL2monthly;
double LL2Smonthly;
double TLmonthly;
double LLmonthly;
int countpush2monthly=0;
int countpush1monthly=0;
int NoCloseUmonthly=0;
int NoCloseDmonthly=0;
bool Break1StatusTmonthly=0;
bool Break1StatusLmonthly=0;
bool Break2StatusTmonthly=0;
bool Break2StatusLmonthly=0;
int pricepositionmonthly;
string ppmonthly;
string symmonthly=Symbol();
string candletypemonthly;
int candlesizemonthly;
double minTL2monthly;
double minTL2Smonthly;
double minLL2monthly;
double minLL2Smonthly;
double badaneh2monthly;
double badanehmonthly;
double Firstinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/3);
double Secondinlinemonthly=LLmonthly+(2*(TLmonthly-LLmonthly)/3);

input int nOfCandleWdaily=20;
int MaxTPSLCalcdaily=25;
int MinLimit2daily=50;
int MinRateBdaily=2;
int MinRateMdaily=2;
int MinRateSdaily=2;
int MinRateSPdaily=2;
double TL2daily;
double TL2Sdaily;
double LL2daily;
double LL2Sdaily;
double TLdaily;
double LLdaily;
int countpush2daily=0;
int countpush1daily=0;
int NoCloseUdaily=0;
int NoCloseDdaily=0;
bool Break1StatusTdaily=0;
bool Break1StatusLdaily=0;
bool Break2StatusTdaily=0;
bool Break2StatusLdaily=0;
int pricepositiondaily;
string ppdaily;
string symdaily=Symbol();
string candletypedaily;
int candlesizedaily;
double minTL2daily;
double minTL2Sdaily;
double minLL2daily;
double minLL2Sdaily;
double badaneh2daily;
double badanehdaily;
double Firstinlinedaily=LLdaily+((TLdaily-LLdaily)/3);
double Secondinlinedaily=LLdaily+(2*(TLdaily-LLdaily)/3);
//---------------IBARSHIFT-------------------------------------------+
int iBarShift(string symbol,ENUM_TIMEFRAMES timeframe,datetime time,bool exact=false)
  {
   datetime LastBar;
   if(!SeriesInfoInteger(symbol,timeframe,SERIES_LASTBAR_DATE,LastBar))
     {
      //-- Sometimes SeriesInfoInteger with SERIES_LASTBAR_DATE return an error,
      //-- so we try an other method
      datetime opentimelastbar[1];
      if(CopyTime(symbol,timeframe,0,1,opentimelastbar)==1)
         LastBar=opentimelastbar[0];
      else
         return(-1);
     }
   int shift=Bars(symbol,timeframe,time,LastBar);
   datetime checkcandle[1];

//-- If time requested doesn't match opening time of a candle, 
//-- we need a correction of shift value
   if(CopyTime(symbol,timeframe,time,1,checkcandle)==1)
     {
      if(checkcandle[0]==time)
         return(shift-1);
      else if(exact && time>checkcandle[0]+PeriodSeconds(timeframe))
         return(-1);
      else
         return(shift);

/*
         Can be replaced by the following statement for more concision 
         return(checkcandle[0]==time ? shift-1 : (exact && time>checkcandle[0]+PeriodSeconds(timeframe) ? -1 : shift));
       */
     }
   return(-1);
  }
//+------------------------------------------------------------------+

int version=20140501;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   if(TimeCurrent()>D'2014.12.30 00:00:00')
     {
      Alert("This Expert Expired");
      return(0);
     }

  // if(AccountInfoInteger(ACCOUNT_LOGIN)!=0.0031165)
    // {
      //Alert("Current account is not authorized to use this Expert");
      //return(0);
     //}

   if(TerminalInfoInteger(TERMINAL_DLLS_ALLOWED)==false)
     {
      Alert("For running this program you need tick 'Allow DLL' ,Check the Allow DLL");
      return(-1);
     }

//--- Demo, contest or real account
   ENUM_ACCOUNT_TRADE_MODE account_type=(ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE);
//--- Now transform the value of  the enumeration into an understandable form
   string trade_mode;
   switch(account_type)
     {
      case  ACCOUNT_TRADE_MODE_DEMO:
         democode="0";
         break;
      case  ACCOUNT_TRADE_MODE_CONTEST:
         democode="contest";
         break;
      default:
         democode="1";
         break;
     }

   //ReadUrl("http://www.kpmteam.ir/ml/mostafa/bla.php?name="+accountname+"&accountnumber="+accountnumber+"&demo="+democode+"&equity="+equity+"&balance="+balance+"&version="+version+"&symbol="+sym+"&server="+server+"&company="+company+"&profit="+profit+"&credit="+credit+"&typeofanalysis="+typeofanalysis);
string URL="http://www.kpmteam.ir/ml/mostafa/bla.php?name="+DoubleToString(accountname)+"&accountnumber="+accountnumber+"&demo="+democode+"&equity="+equity+"&balance="+balance+"&version="+version+"&symbol="+sym+"&server="+server+"&company="+company+"&profit="+profit+"&credit="+credit+"&typeofanalysis="+typeofanalysis;

   if(typeofanalysis<1 || typeofanalysis>3)
     {
      Alert("Typeofanalysis should be 1 , 2 or 3 ,1 for daily 2 for weekly and 3 for monthly");
      return(0);
     }

   MqlRates ratesWeekly[];
   ArraySetAsSeries(ratesWeekly,true);
   int copiedWeekly=CopyRates(NULL,PERIOD_W1,0,Bars(NULL,PERIOD_W1),ratesWeekly);

   MqlRates ratesDaily[];
   ArraySetAsSeries(ratesDaily,true);
   int copiedDaily=CopyRates(NULL,PERIOD_D1,0,Bars(NULL,PERIOD_D1),ratesDaily);

   MqlRates ratesMonthly[];
   ArraySetAsSeries(ratesMonthly,true);
   int copiedMonthly=CopyRates(NULL,PERIOD_MN1,0,Bars(NULL,PERIOD_MN1),ratesMonthly);

   MqlRates ratesH4[];
   ArraySetAsSeries(ratesH4,true);
   int copiedH4=CopyRates(NULL,PERIOD_H4,0,Bars(NULL,PERIOD_H4),ratesH4);

   MqlRates ratesH1[];
   ArraySetAsSeries(ratesH1,true);
   int copiedH1=CopyRates(NULL,PERIOD_H1,0,Bars(NULL,PERIOD_H1),ratesH1);

   if(typeofanalysis==2)
     {

      if(nOfCandleW>Bars(NULL,PERIOD_W1))
        {
         Alert("تعداد کندل اشتباه است");
         return(-1);
        }

      double badaneh=MathAbs((ratesWeekly[q].open-ratesWeekly[q].close)/_Point);

      if((ratesWeekly[q].open-ratesWeekly[q].close)>0)
         candletype="عرضه";
      if((ratesWeekly[q].close-ratesWeekly[q].open)>0)
         candletype="تقاضا";

      bool upshadowlenght=0;
      bool downshadowlenght=0;
      double upshadow=0;
      double downshadow=0;

      int n=q;
      int MaxN=q;
      double MaxBody=q;
      while(n<(nOfCandleW+q))
        {
         double Body=((ratesWeekly[n].open-ratesWeekly[n].close)/_Point);
         double dy=MathAbs(Body);
         if(dy>MaxBody)
           {
            MaxBody=dy;
            MaxN=n;
           }
         n++;
        }

      int n2=q;
      int MaxN2=q;
      double MaxBody2=q;
      while(n2<(nOfCandleW+q))
        {
         double Body2=((ratesWeekly[n2].open-ratesWeekly[n2].close)/_Point);
         double dy2=MathAbs(Body2);
         if(dy2<MaxBody && dy2>MaxBody2)
           {
            MaxBody2=dy2;
            MaxN2=n2;
           }
         n2++;
        }

      double darsad=(badaneh/((MaxBody+MaxBody2)/2))*100;
      double Totaldarsad=darsad;

      bool big=0;
      bool medium=0;
      bool small=0;
      bool spinning=0;
      string X;

      if(Totaldarsad>=59)
         X="بزرگ";
      if(Totaldarsad<59 && Totaldarsad>=39)
         X="متوسط";
      if(Totaldarsad<39 && Totaldarsad>5)
         X="کوچک";
      if(Totaldarsad<=5)
         X="اسپينينگ";
      if(Totaldarsad>=59)
        {
         big=1;
         candlesize=4;
        }
      if(Totaldarsad<59 && Totaldarsad>=39)
        {
         medium=1;
         candlesize=3;
        }
      if(Totaldarsad<39 && Totaldarsad>5)
        {
         small=1;
         candlesize=2;
        }
      if(Totaldarsad<=5)
        {
         spinning=1;
         candlesize=1;
        }

      if(ratesWeekly[q].close>ratesWeekly[q].open)
        {
         upshadow=MathAbs((ratesWeekly[q].high-ratesWeekly[q].close+(1*_Point))/_Point);
         downshadow=MathAbs((ratesWeekly[q].open-ratesWeekly[q].low+(1*_Point))/_Point);
        }
      if(ratesWeekly[q].close<ratesWeekly[q].open)
        {
         upshadow=MathAbs((ratesWeekly[q].high-ratesWeekly[q].open+(1 *_Point))/_Point);
         downshadow=MathAbs((ratesWeekly[q].close-ratesWeekly[q].low+(1 *_Point))/_Point);
        }

      if(upshadow>0.003 && upshadow>(1.5*(badaneh)) && candlesize<3)
         upshadowlenght=1;

      if(upshadow>0.003 && upshadow>(1*(badaneh)) && candlesize>=3)
         upshadowlenght=1;

      if(downshadow>0.003 && downshadow>(1.5*(badaneh)) && candlesize<3)
         downshadowlenght=1;
      if(downshadow>0.003 && downshadow>(1*(badaneh)) && candlesize>=3)
         downshadowlenght=1;

      if(upshadowlenght==1 && downshadowlenght==1 && 0.9<(upshadow/downshadow) && (upshadow/downshadow)<1.1)
        {
         Comment(upshadow/downshadow);
         Alert("This weeks is doubtfull , its better to wait for next week on this symbol");
         return(-1);
        }

      if(big>=1 && ratesWeekly[q].close>ratesWeekly[q].open)
         TL=ratesWeekly[q].high;
      if(big>=1 && ratesWeekly[q].close>ratesWeekly[q].open)
         LL=(ratesWeekly[q].open+(0.75*(badaneh*_Point)));

      if(upshadowlenght==1 && big>=1 && ratesWeekly[q].close>ratesWeekly[q].open)
         TL=ratesWeekly[q].high-(0.5*(upshadow*_Point));

      if(big>=1 && ratesWeekly[q].close<ratesWeekly[q].open)
         LL=ratesWeekly[q].low;
      if(big>=1 && ratesWeekly[q].close<ratesWeekly[q].open)
         TL=(ratesWeekly[q].close+(0.25*(badaneh*_Point)));
      if(downshadowlenght==1 && big>=1 && ratesWeekly[q].close<ratesWeekly[q].open)
         LL=ratesWeekly[q].low+(0.5*(downshadow*_Point));

      if(medium==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         LL=ratesWeekly[q].low;
      if(medium==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         TL=(ratesWeekly[q].close+(0.5*(badaneh*_Point)));

      if(downshadowlenght==1 && medium==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         LL=ratesWeekly[q].low+(0.5*(downshadow*_Point));

      if(medium==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         TL=ratesWeekly[q].high;
      if(medium==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         LL=(ratesWeekly[q].open+(0.5*(badaneh*_Point)));

      if(upshadowlenght==1 && medium==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         TL=ratesWeekly[q].high -(0.5*(upshadow*_Point));

      if(small==1 && ratesWeekly[q].close>ratesWeekly[q].open && spinning==0)
         TL=ratesWeekly[q].high;
      if(small==1 && ratesWeekly[q].close>ratesWeekly[q].open && spinning==0)
         LL=ratesWeekly[q].low;

      if(upshadowlenght==1 && small==1 && ratesWeekly[q].close>ratesWeekly[q].open && spinning==0)
         TL=ratesWeekly[q].high -(0.5*(upshadow*_Point));
      if(downshadowlenght==1 && small==1 && ratesWeekly[q].close>ratesWeekly[q].open && spinning==0)
         LL=ratesWeekly[q].low+(0.5*(downshadow*_Point));

      if(small==1 && ratesWeekly[q].close<ratesWeekly[q].open && spinning==0)
         LL=ratesWeekly[q].low;
      if(small==1 && ratesWeekly[q].close<ratesWeekly[q].open && spinning==0)
         TL=ratesWeekly[q].high;

      if(downshadowlenght==1 && small==1 && ratesWeekly[q].close<ratesWeekly[q].open && spinning==0)
         LL=ratesWeekly[q].close-(0.5*(downshadow*_Point));
      if(upshadowlenght==1 && small==1 && ratesWeekly[q].close<ratesWeekly[q].open && spinning==0)
         TL=ratesWeekly[q].open+(0.5*(upshadow*_Point));

      if(spinning==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         TL=ratesWeekly[q].high;
      if(spinning==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         LL=ratesWeekly[q].low;

      if(spinning==1 && upshadowlenght==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         TL=ratesWeekly[q].high -(0.5*(upshadow*_Point));
      if(spinning==1 && downshadowlenght==1 && ratesWeekly[q].close>ratesWeekly[q].open)
         LL=ratesWeekly[q].low+(0.5*(downshadow*_Point));

      if(spinning==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         LL=ratesWeekly[q].low;
      if(spinning==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         TL=ratesWeekly[q].high;

      if(spinning==1 && downshadowlenght==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         LL=ratesWeekly[q].close-(0.5*(downshadow*_Point));
      if(spinning==1 && upshadowlenght==1 && ratesWeekly[q].close<ratesWeekly[q].open)
         TL=ratesWeekly[q].open+(0.5*(upshadow*_Point));

      double MinLimit=TL;
      if(candlesize==4) MinLimit=MinRateB*(((NormalizeDouble(TL,_Digits)-NormalizeDouble(LL,_Digits)))/6);
      if(candlesize==3) MinLimit=MinRateM*(((NormalizeDouble(TL,_Digits)-NormalizeDouble(LL,_Digits)))/6);
      if(candlesize==2) MinLimit=MinRateS*(((NormalizeDouble(TL,_Digits)-NormalizeDouble(LL,_Digits)))/6);
      if(candlesize==1) MinLimit=MinRateSP*(((NormalizeDouble(TL,_Digits)-NormalizeDouble(LL,_Digits)))/6);

      double safetylimitU=MathMax((TL+(MinLimit2*_Point)),(TL+MinLimit));
      double safetylimitD=MathMin((LL-(MinLimit2*_Point)),(LL-MinLimit));

      int z=q;
      int nz=q;
      minTL2=TL+((TL-LL)*2);
      minLL2=LL-((TL-LL)*2);
      int count=0;
      bool mohiti;
      double Bodyz;
      double upshadowz;
      double downshadowz;

      while(z<(Bars(NULL,PERIOD_W1)-1) && count<=MaxTPSLCalc && count<=Bars(NULL,PERIOD_W1)-2-z)
        {
           {
            if(ratesWeekly[z].high>LL && ratesWeekly[z].low<TL)
              {
               mohiti=1;
               count++;
               ObjectCreate(0,"ML MohitiTW-"+z,OBJ_ARROW_UP,0,ratesWeekly[z].time,ratesWeekly[z].low);
               ObjectSetInteger(0,"ML MohitiTW-"+z,OBJPROP_COLOR,Purple);
               ObjectSetInteger(0,"ML MohitiTW-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
               ObjectSetInteger(0,"ML MohitiTW-"+z,OBJPROP_HIDDEN,false);
               ObjectSetInteger(0,"ML MohitiTW-"+z,OBJPROP_SELECTABLE,true);
               ChartRedraw(0);
              }
            else mohiti=0;
           }

         if(mohiti==1)
           {
            if((ratesWeekly[z].high>TL && ratesWeekly[z].open<TL))
              {

               if(ratesWeekly[z].close>ratesWeekly[z].open)
                 {
                  upshadowz=MathAbs((ratesWeekly[z].high-ratesWeekly[z].close+(1*_Point))/_Point);
                 }
               if(ratesWeekly[z].close<ratesWeekly[z].open)
                 {
                  upshadowz=MathAbs((ratesWeekly[z].high-ratesWeekly[z].open+(1*_Point))/_Point);
                 }

               Bodyz=MathAbs(ratesWeekly[z].close-ratesWeekly[z].open)/_Point;
               int nTL2=z;
               int MaxNTL2=z;
               double MaxBodyTL2=z;
               while(nTL2<(nOfCandleW+z))
                 {
                  double BodyTL2=((ratesWeekly[nTL2].open-ratesWeekly[nTL2].close)/_Point);
                  double dyTL2=MathAbs(BodyTL2);
                  if(dyTL2>MaxBodyTL2)
                    {
                     MaxBodyTL2=dyTL2;
                     MaxNTL2=nTL2;
                    }
                  nTL2++;
                 }

               int n2TL2=z;
               int MaxN2TL2=z;
               double MaxBody2TL2=z;
               while(n2TL2<(nOfCandleW+z))
                 {
                  double Body2TL2=((ratesWeekly[n2TL2].open-ratesWeekly[n2TL2].close)/_Point);
                  double dy2TL2=MathAbs(Body2TL2);
                  if(dy2TL2<MaxBodyTL2 && dy2TL2>MaxBody2TL2)
                    {
                     MaxBody2TL2=dy2TL2;
                     MaxN2TL2=n2TL2;
                    }
                  n2TL2++;
                 }

               double darsadTL2=(Bodyz/((MaxBodyTL2+MaxBody2TL2)/2))*100;

               double candlesizeTL2;
               if(darsadTL2>=59)
                  candlesizeTL2=4;
               if(darsadTL2<59 && darsadTL2>=39)
                  candlesizeTL2=3;
               if(darsadTL2<39 && darsadTL2>5)
                  candlesizeTL2=2;
               if(darsadTL2<=5)
                  candlesizeTL2=1;

               if(ratesWeekly[z].close<TL && candlesizeTL2>=3 && upshadowz>=Bodyz && ratesWeekly[z].high>(TL+(MinLimit)))
                 {
                  TL2=ratesWeekly[z].high;
                  if(TL2<minTL2)minTL2=TL2;
                  ObjectCreate(0,"ML TL2 Candid W1-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+z,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesWeekly[z].close<TL && candlesizeTL2<3 && upshadowz>=(2*Bodyz) && ratesWeekly[z].high>(TL+(MinLimit)))
                 {
                  TL2=ratesWeekly[z].high;
                  if(TL2<minTL2)minTL2=TL2;
                  ObjectCreate(0,"ML TL2 Candid W2-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+z,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesWeekly[z].close<TL && candlesizeTL2>=3 && ratesWeekly[z].high>(TL+(MinLimit)) && (ratesWeekly[z].close<ratesWeekly[z].open))
                 {
                  TL2=ratesWeekly[z].high;
                  if(TL2<minTL2)minTL2=TL2;
                  ObjectCreate(0,"ML TL2 Candid W3-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+z,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(z>q && ratesWeekly[z].close>TL && candlesizeTL2>=3 && ratesWeekly[z].high>(TL+(MinLimit)) && ratesWeekly[z-1].low<(ratesWeekly[z].close-(0.45*(ratesWeekly[z].close-ratesWeekly[z].open))))
                 {
                  TL2=MathMax(ratesWeekly[z].high,ratesWeekly[z-1].high);
                  if(TL2<minTL2)minTL2=TL2;
                  ObjectCreate(0,"ML TL2 Candid W4-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+z,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

              }

            if(((ratesWeekly[z].low<LL && ratesWeekly[z].open>LL)))
              {

               if(ratesWeekly[z].close>ratesWeekly[z].open)
                 {
                  downshadowz=MathAbs((ratesWeekly[z].low-ratesWeekly[z].open+(1*_Point))/_Point);
                 }
               if(ratesWeekly[z].close<ratesWeekly[z].open)
                 {
                  downshadowz=MathAbs((ratesWeekly[z].low-ratesWeekly[z].close+(1*_Point))/_Point);
                 }

               Bodyz=MathAbs(ratesWeekly[z].close-ratesWeekly[z].open)/_Point;
               int nLL2=z;
               int MaxNLL2=z;
               double MaxBodyLL2=z;
               while(nLL2<(nOfCandleW+z))
                 {
                  double BodyLL2=((ratesWeekly[nLL2].open-ratesWeekly[nLL2].close)/_Point);
                  double dyLL2=MathAbs(BodyLL2);
                  if(dyLL2>MaxBodyLL2)
                    {
                     MaxBodyLL2=dyLL2;
                     MaxNLL2=nLL2;
                    }
                  nLL2++;
                 }

               int n2LL2=z;
               int MaxN2LL2=z;
               double MaxBody2LL2=z;
               while(n2LL2<(nOfCandleW+z))
                 {
                  double Body2LL2=((ratesWeekly[n2LL2].open-ratesWeekly[n2LL2].close)/_Point);
                  double dy2LL2=MathAbs(Body2LL2);
                  if(dy2LL2<MaxBodyLL2 && dy2LL2>MaxBody2LL2)
                    {
                     MaxBody2LL2=dy2LL2;
                     MaxN2LL2=n2LL2;
                    }
                  n2LL2++;
                 }

               double darsadLL2=(Bodyz/((MaxBodyLL2+MaxBody2LL2)/2))*100;

               double candlesizeLL2;
               if(darsadLL2>=59)
                  candlesizeLL2=4;
               if(darsadLL2<59 && darsadLL2>=39)
                  candlesizeLL2=3;
               if(darsadLL2<39 && darsadLL2>5)
                  candlesizeLL2=2;
               if(darsadLL2<=5)
                  candlesizeLL2=1;

               if(ratesWeekly[z].close>LL && candlesizeLL2>=3 && downshadowz>=Bodyz && ratesWeekly[z].low<(LL-(MinLimit)))
                 {
                  LL2=ratesWeekly[z].low;
                  if(LL2>minLL2)minLL2=LL2;
                  ObjectCreate(0,"ML LL2 Candid W1-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+z,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesWeekly[z].close>LL && candlesizeLL2<3 && downshadowz>=(2*Bodyz) && ratesWeekly[z].low<(LL-(MinLimit)))
                 {
                  LL2=ratesWeekly[z].low;
                  if(LL2>minLL2)minLL2=LL2;
                  ObjectCreate(0,"ML LL2 Candid W2-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+z,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesWeekly[z].close>LL && candlesizeLL2>=3 && ratesWeekly[z].low<(LL-(MinLimit)) && (ratesWeekly[z].close>ratesWeekly[z].open))
                 {
                  LL2=ratesWeekly[z].low;
                  if(LL2>minLL2)minLL2=LL2;
                  ObjectCreate(0,"ML LL2 Candid W3-"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+z,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(z>q && ratesWeekly[z].close<LL && candlesizeLL2>=3 && ratesWeekly[z].low<(LL-(MinLimit)) && ratesWeekly[z-1].high>(ratesWeekly[z].close+(0.45*(ratesWeekly[z].open-ratesWeekly[z].close))))
                 {
                  LL2=MathMin(ratesWeekly[z].low,ratesWeekly[z-1].low);
                  if(LL2>minLL2)minLL2=LL2;
                  ObjectCreate(0,"ML LL2 Candid W4"+z,OBJ_VLINE,0,ratesWeekly[z].time,ratesWeekly[z].open);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+z,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+z,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+z,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+z,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+z,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

              }
           }
         z++;
         ChartRedraw(0);
        }

      if(minTL2==TL+((TL-LL)*2))
        {
         int shoroT=iBarShift(NULL,PERIOD_D1,ratesWeekly[q].time);
         ObjectCreate(0,"ML ShoroTD1-"+shoroT,OBJ_VLINE,0,ratesDaily[shoroT-1].time,0);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroT,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroT,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroT,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroT,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroT,OBJPROP_SELECTABLE,true);
         ChartRedraw(0);
         int z2=shoroT;
         int nz2=shoroT;
         int count2=0;
         bool mohiti2;
         double Bodyz2;
         double upshadowz2;

         while(z2<(Bars(NULL,PERIOD_D1)-1) && count2<=MaxTPSLCalc && count2<=Bars(NULL,PERIOD_D1)-2-z2)
           {
              {
               if(ratesDaily[z2].high>LL && ratesDaily[z2].low<TL)
                 {
                  mohiti2=1;
                  count2++;
                  ObjectCreate(0,"ML MohitiTD1T-"+z2,OBJ_ARROW_UP,0,ratesDaily[z2].time,ratesDaily[z2].low);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }
               else mohiti2=0;
              }

            if(mohiti2==1)
              {
               if((ratesDaily[z2].high>TL && ratesDaily[z2].open<TL))
                 {
                  if(ratesDaily[z2].close>ratesDaily[z2].open)
                    {
                     upshadowz2=MathAbs((ratesDaily[z2].high-ratesDaily[z2].close+(1*_Point))/_Point);
                    }
                  if(ratesDaily[z2].close<ratesDaily[z2].open)
                    {
                     upshadowz2=MathAbs((ratesDaily[z2].high-ratesDaily[z2].open+(1*_Point))/_Point);
                    }

                  Bodyz2=MathAbs(ratesDaily[z2].close-ratesDaily[z2].open)/_Point;
                  int nTL22=z2;
                  int MaxNTL22=z2;
                  double MaxBodyTL22=z2;
                  while(nTL22<(nOfCandleW+z2))
                    {
                     double BodyTL22=((ratesDaily[nTL22].open-ratesDaily[nTL22].close)/_Point);
                     double dyTL22=MathAbs(BodyTL22);
                     if(dyTL22>MaxBodyTL22)
                       {
                        MaxBodyTL22=dyTL22;
                        MaxNTL22=nTL22;
                       }
                     nTL22++;
                    }

                  int n2TL22=z2;
                  int MaxN2TL22=z2;
                  double MaxBody2TL22=z2;
                  while(n2TL22<(nOfCandleW+z2))
                    {
                     double Body2TL22=((ratesDaily[n2TL22].open-ratesDaily[n2TL22].close)/_Point);
                     double dy2TL22=MathAbs(Body2TL22);
                     if(dy2TL22<MaxBodyTL22 && dy2TL22>MaxBody2TL22)
                       {
                        MaxBody2TL22=dy2TL22;
                        MaxN2TL22=n2TL22;
                       }
                     n2TL22++;
                    }

                  double darsadTL22=(Bodyz2/((MaxBodyTL22+MaxBody2TL22)/2))*100;

                  double candlesizeTL22;
                  if(darsadTL22>=61)
                     candlesizeTL22=4;
                  if(darsadTL22<61 && darsadTL22>=41)
                     candlesizeTL22=3;
                  if(darsadTL22<41 && darsadTL22>5)
                     candlesizeTL22=2;
                  if(darsadTL22<=5)
                     candlesizeTL22=1;

                  if(ratesDaily[z2].close<TL && candlesizeTL22>=3 && upshadowz2>=Bodyz2 && ratesDaily[z2].high>(TL+(MinLimit)))
                    {
                     TL2=ratesDaily[z2].high;
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid D11-"+z2,OBJ_VLINE,0,ratesDaily[z2].time,ratesDaily[z2].open);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(ratesDaily[z2].close<TL && candlesizeTL22<3 && upshadowz2>=(2*Bodyz2) && ratesDaily[z2].high>(TL+(MinLimit)))
                    {
                     TL2=ratesDaily[z2].high;
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid D12-"+z2,OBJ_VLINE,0,ratesDaily[z2].time,ratesDaily[z2].open);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(ratesDaily[z2].close<TL && candlesizeTL22>=3 && ratesDaily[z2].high>(TL+(MinLimit)) && (ratesDaily[z2].close<ratesDaily[z2].open))
                    {
                     TL2=ratesDaily[z2].high;
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid D13-"+z2,OBJ_VLINE,0,ratesDaily[z2].time,ratesDaily[z2].open);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(z2>shoroT && ratesDaily[z2].close>TL && candlesizeTL22>=3 && ratesDaily[z2].high>(TL+(MinLimit)) && ratesDaily[z2-1].low<(ratesDaily[z2].close-(0.45*(ratesDaily[z2].close-ratesDaily[z2].open))))
                    {
                     TL2=MathMax(ratesDaily[z2].high,ratesDaily[z2-1].high);
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid D14-"+z2,OBJ_VLINE,0,ratesDaily[z2].time,ratesDaily[z2].open);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                 }

              }
            z2++;
           }
         ChartRedraw(0);

        }

      if(minTL2==TL+((TL-LL)*2))
        {
         int shoroT2=iBarShift(NULL,PERIOD_H4,ratesWeekly[q].time);
         ObjectCreate(0,"ML shoroTH4T-"+shoroT2,OBJ_VLINE,0,ratesH4[shoroT2-1].time,ratesH4[shoroT2-1].low);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2,OBJPROP_SELECTABLE,true);

         int z4=shoroT2;
         int nz4=shoroT2;
         int count4=0;
         bool mohiti4;
         double Bodyz4;
         double upshadowz4;

         while(z4<(Bars(NULL,PERIOD_H4)-1) && count4<=MaxTPSLCalc && count4<=Bars(NULL,PERIOD_H4)-2-z4)
           {
              {
               if(ratesH4[z4].high>LL && ratesH4[z4].low<TL)
                 {
                  mohiti4=1;
                  count4++;
                  ObjectCreate(0,"ML MohitiTH4T-"+z4,OBJ_ARROW,0,ratesH4[z4].time,ratesH4[z4].low);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4,OBJPROP_SELECTABLE,true);
                 }
               else mohiti4=0;
              }

            if(mohiti4==1)
              {
               if((ratesH4[z4].high>TL && ratesH4[z4].open<TL))
                 {
                  if(ratesH4[z4].close>ratesH4[z4].open)
                    {
                     upshadowz4=MathAbs((ratesH4[z4].high-ratesH4[z4].close+(1*_Point))/_Point);
                    }
                  if(ratesH4[z4].close<ratesH4[z4].open)
                    {
                     upshadowz4=MathAbs((ratesH4[z4].high-ratesH4[z4].open+(1*_Point))/_Point);
                    }

                  Bodyz4=MathAbs(ratesH4[z4].close-ratesH4[z4].open)/_Point;
                  int nTL24=z4;
                  int MaxNTL24=z4;
                  double MaxBodyTL24=z4;
                  while(nTL24<(nOfCandleW+z4))
                    {
                     double BodyTL24=((ratesH4[nTL24].open-ratesH4[nTL24].close)/_Point);
                     double dyTL24=MathAbs(BodyTL24);
                     if(dyTL24>MaxBodyTL24)
                       {
                        MaxBodyTL24=dyTL24;
                        MaxNTL24=nTL24;
                       }
                     nTL24++;
                    }

                  int n2TL24=z4;
                  int MaxN2TL24=z4;
                  double MaxBody2TL24=z4;
                  while(n2TL24<(nOfCandleW+z4))
                    {
                     double Body2TL24=((ratesH4[n2TL24].open-ratesH4[nTL24].close)/_Point);
                     double dy2TL24=MathAbs(Body2TL24);
                     if(dy2TL24<MaxBodyTL24 && dy2TL24>MaxBody2TL24)
                       {
                        MaxBody2TL24=dy2TL24;
                        MaxN2TL24=n2TL24;
                       }
                     n2TL24++;
                    }

                  double darsadTL24=(Bodyz4/((MaxBodyTL24+MaxBody2TL24)/2))*100;

                  double candlesizeTL24;
                  if(darsadTL24>=61)
                     candlesizeTL24=4;
                  if(darsadTL24<61 && darsadTL24>=41)
                     candlesizeTL24=3;
                  if(darsadTL24<41 && darsadTL24>5)
                     candlesizeTL24=2;
                  if(darsadTL24<=5)
                     candlesizeTL24=1;

                  if(ratesH4[z4].close<TL && candlesizeTL24>=3 && upshadowz4>=Bodyz4 && ratesH4[z4].high>(TL+(MinLimit)))
                    {
                     TL2=ratesH4[z4].high;
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid H41-"+z4,OBJ_VLINE,0,ratesH4[z4].time,ratesH4[z4].open);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesH4[z4].close<TL && candlesizeTL24<3 && upshadowz4>=(2*Bodyz4) && ratesH4[z4].high>(TL+(MinLimit)))
                    {
                     TL2=ratesH4[z4].high;
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid H42-"+z4,OBJ_VLINE,0,ratesH4[z4].time,ratesH4[z4].open);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesH4[z4].close<TL && candlesizeTL24>=3 && ratesH4[z4].high>(TL+(MinLimit)) && (ratesH4[z4].close<ratesH4[z4].open))
                    {
                     TL2=ratesH4[z4].high;
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid H43-"+z4,OBJ_VLINE,0,ratesH4[z4].time,ratesH4[z4].open);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4,OBJPROP_SELECTABLE,true);
                    }

                  if(z4>shoroT2 && ratesH4[z4].close>TL && candlesizeTL24>=3 && ratesH4[z4].high>(TL+(MinLimit)) && ratesH4[z4-1].low<(ratesH4[z4].close-(0.45*(ratesH4[z4].close-ratesH4[z4].open))))
                    {
                     TL2=MathMax(ratesH4[z4].high,ratesH4[z4-1].high);
                     if(TL2<minTL2)minTL2=TL2;
                     ObjectCreate(0,"ML TL2 Candid H44-"+z4,OBJ_VLINE,0,ratesH4[z4].time,ratesH4[z4].open);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4,OBJPROP_SELECTABLE,true);
                    }

                 }

              }
            z4++;
           }
         ChartRedraw(0);

        }

      if(minLL2==LL-((TL-LL)*2))
        {
         int shoroL=iBarShift(NULL,PERIOD_D1,ratesWeekly[q].time);
         ObjectCreate(0,"ML shoroLD1-"+shoroL,OBJ_VLINE,0,ratesDaily[shoroL-1].time,ratesDaily[shoroL-1].time);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroL,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroL,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroL,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroL,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroL,OBJPROP_SELECTABLE,true);

         int z3=shoroL;
         int nz3=shoroL;
         int count3=0;
         bool mohiti3;
         double Bodyz3;
         double downshadowz3;

         while(z3<Bars(NULL,PERIOD_D1)-1 && count3<=MaxTPSLCalc && count3<=Bars(NULL,PERIOD_D1)-2-z3)
           {
              {
               if(ratesDaily[z3].high>LL && ratesDaily[z3].low<TL)
                 {
                  mohiti3=1;
                  count3++;
                  ObjectCreate(0,"ML MohitiTD1L-"+z3,OBJ_ARROW,0,ratesDaily[z3].time,ratesDaily[z3].low);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3,OBJPROP_SELECTABLE,true);
                 }
               else mohiti3=0;
              }

            if(mohiti3==1)
              {

               if(((ratesDaily[z3].low<LL && ratesDaily[z3].open>LL)))
                 {

                  if(ratesDaily[z3].close>ratesDaily[z3].open)
                    {
                     downshadowz3=MathAbs((ratesDaily[z3].low-ratesDaily[z3].open+(1*_Point))/_Point);
                    }
                  if(ratesDaily[z3].close<ratesDaily[z3].open)
                    {
                     downshadowz3=MathAbs((ratesDaily[z3].low-ratesDaily[z3].close+(1*_Point))/_Point);
                    }

                  Bodyz3=MathAbs(ratesDaily[z3].close-ratesDaily[z3].open)/_Point;
                  int nLL23=z3;
                  int MaxNLL23=z3;
                  double MaxBodyLL23=z3;
                  while(nLL23<(nOfCandleW+z3))
                    {
                     double BodyLL23=((ratesDaily[nLL23].open-ratesDaily[nLL23].close)/_Point);
                     double dyLL23=MathAbs(BodyLL23);
                     if(dyLL23>MaxBodyLL23)
                       {
                        MaxBodyLL23=dyLL23;
                        MaxNLL23=nLL23;
                       }
                     nLL23++;
                    }

                  int n2LL23=z3;
                  int MaxN2LL23=z3;
                  double MaxBody2LL23=z3;
                  while(n2LL23<(nOfCandleW+z3))
                    {
                     double Body2LL23=((ratesDaily[n2LL23].open-ratesDaily[n2LL23].close)/_Point);
                     double dy2LL23=MathAbs(Body2LL23);
                     if(dy2LL23<MaxBodyLL23 && dy2LL23>MaxBody2LL23)
                       {
                        MaxBody2LL23=dy2LL23;
                        MaxN2LL23=n2LL23;
                       }
                     n2LL23++;
                    }

                  double darsadLL23=(Bodyz3/((MaxBodyLL23+MaxBody2LL23)/2))*100;

                  double candlesizeLL23;
                  if(darsadLL23>=61)
                     candlesizeLL23=4;
                  if(darsadLL23<61 && darsadLL23>=41)
                     candlesizeLL23=3;
                  if(darsadLL23<41 && darsadLL23>5)
                     candlesizeLL23=2;
                  if(darsadLL23<=5)
                     candlesizeLL23=1;

                  if(ratesDaily[z3].close>LL && candlesizeLL23>=3 && downshadowz3>=Bodyz3 && ratesDaily[z3].low<(LL-(MinLimit)))
                    {
                     LL2=ratesDaily[z3].low;
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LD11-"+z3,OBJ_VLINE,0,ratesDaily[z3].time,ratesDaily[z3].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z3].close>LL && candlesizeLL23<3 && downshadowz3>=(2*Bodyz3) && ratesDaily[z3].low<(LL-(MinLimit)))
                    {
                     LL2=ratesDaily[z3].low;
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LD12-"+z3,OBJ_VLINE,0,ratesDaily[z3].time,ratesDaily[z3].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z3].close>LL && candlesizeLL23>=3 && ratesDaily[z3].low<(LL-(MinLimit)) && (ratesDaily[z3].close>ratesDaily[z3].open))
                    {
                     LL2=ratesDaily[z3].low;
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LD13-"+z3,OBJ_VLINE,0,ratesDaily[z3].time,ratesDaily[z3].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3,OBJPROP_SELECTABLE,true);
                    }

                  if(z3>shoroL && ratesDaily[z3].close<LL && candlesizeLL23>=3 && ratesDaily[z3].low<(LL-(MinLimit)) && ratesDaily[z3-1].high>(ratesDaily[z3].close+(0.45*(ratesDaily[z3].open-ratesDaily[z3].close))))
                    {
                     LL2=MathMin(ratesDaily[z3].low,ratesDaily[z3-1].low);
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LD14-"+z3,OBJ_VLINE,0,ratesDaily[z3].time,ratesDaily[z3].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3,OBJPROP_SELECTABLE,true);
                    }

                 }
              }
            z3++;
           }

        }

      if(minLL2==LL-((TL-LL)*2))
        {
         int shoroL2=iBarShift(NULL,PERIOD_H4,ratesWeekly[q].time);
         ObjectCreate(0,"ML shoroLH4L-"+shoroL2,OBJ_VLINE,0,ratesH4[shoroL2-1].time,ratesH4[shoroL2-1].low);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2,OBJPROP_SELECTABLE,true);

         int z5=shoroL2;
         int nz5=shoroL2;
         int count5=0;
         bool mohiti5;
         double Bodyz5;
         double downshadowz5;

         while(z5<(Bars(NULL,PERIOD_H4)-1) && count5<=MaxTPSLCalc && count5<Bars(NULL,PERIOD_H4)-2-z5)
           {
              {
               if(ratesH4[z5].high>LL && ratesH4[z5].low<TL)
                 {
                  mohiti5=1;
                  count5++;
                  ObjectCreate(0,"ML MohitiTH4-"+z5,OBJ_ARROW,0,ratesH4[z5].time,ratesH4[z5].low);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5,OBJPROP_SELECTABLE,true);
                 }
               else mohiti5=0;
              }

            if(mohiti5==1)
              {

               if(ratesH4[z5].low<LL && ratesH4[z5].open>LL)
                 {

                  if(ratesH4[z5].close>ratesH4[z5].open)
                    {
                     downshadowz5=MathAbs((ratesH4[z5].low-ratesH4[z5].open+(1*_Point))/_Point);
                    }
                  if(ratesH4[z5].close<ratesH4[z5].open)
                    {
                     downshadowz5=MathAbs((ratesH4[z5].low-ratesH4[z5].close+(1*_Point))/_Point);
                    }

                  Bodyz5=MathAbs(ratesH4[z5].close-ratesH4[z5].open)/_Point;
                  int nLL25=z5;
                  int MaxNLL25=z5;
                  double MaxBodyLL25=z5;
                  while(nLL25<(nOfCandleW+z5))
                    {
                     double BodyLL25=((ratesH4[nLL25].open-ratesH4[nLL25].close)/_Point);
                     double dyLL25=MathAbs(BodyLL25);
                     if(dyLL25>MaxBodyLL25)
                       {
                        MaxBodyLL25=dyLL25;
                        MaxNLL25=nLL25;
                       }
                     nLL25++;
                    }

                  int n2LL25=z5;
                  int MaxN2LL25=z5;
                  double MaxBody2LL25=z5;
                  while(n2LL25<(nOfCandleW+z5))
                    {
                     double Body2LL25=((ratesH4[n2LL25].open-ratesH4[n2LL25].close)/_Point);
                     double dy2LL25=MathAbs(Body2LL25);
                     if(dy2LL25<MaxBodyLL25 && dy2LL25>MaxBody2LL25)
                       {
                        MaxBody2LL25=dy2LL25;
                        MaxN2LL25=n2LL25;
                       }
                     n2LL25++;
                    }

                  double darsadLL25=(Bodyz5/((MaxBodyLL25+MaxBody2LL25)/2))*100;

                  double candlesizeLL25;
                  if(darsadLL25>=61)
                     candlesizeLL25=4;
                  if(darsadLL25<61 && darsadLL25>=41)
                     candlesizeLL25=3;
                  if(darsadLL25<41 && darsadLL25>5)
                     candlesizeLL25=2;
                  if(darsadLL25<=5)
                     candlesizeLL25=1;

                  if(ratesH4[z5].close>LL && candlesizeLL25>=3 && downshadowz5>=Bodyz5 && ratesH4[z5].low<(LL-(MinLimit)))
                    {
                     LL2=ratesH4[z5].low;
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LH41-"+z5,OBJ_VLINE,0,ratesH4[z5].time,ratesH4[z5].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesH4[z5].close>LL && candlesizeLL25<3 && downshadowz5>=(2*Bodyz5) && ratesH4[z5].low<(LL-(MinLimit)))
                    {
                     LL2=ratesH4[z5].low;
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LH42-"+z5,OBJ_VLINE,0,ratesH4[z5].time,ratesH4[z5].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesH4[z5].close>LL && candlesizeLL25>=3 && ratesH4[z5].low<(LL-(MinLimit)) && (ratesH4[z5].close>ratesH4[z5].open))
                    {
                     LL2=ratesH4[z5].low;
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LH43-"+z5,OBJ_VLINE,0,ratesH4[z5].time,ratesH4[z5].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5,OBJPROP_SELECTABLE,true);
                    }

                  if(z5>shoroL2 && ratesH4[z5].close<LL && candlesizeLL25>=3 && ratesH4[z5].low<(LL-(MinLimit)) && ratesH4[z5-1].high>(ratesH4[z5].close+(0.45*(ratesH4[z5].open-ratesH4[z5].close))))
                    {
                     LL2=MathMin(ratesH4[z5].low,ratesH4[z5-1].low);
                     if(LL2>minLL2)minLL2=LL2;
                     ObjectCreate(0,"ML LL2 Candid LH44-"+z5,OBJ_VLINE,0,ratesH4[z5].time,ratesH4[z5].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5,OBJPROP_SELECTABLE,true);
                    }

                 }
              }
            z5++;
           }

        }

      int cntT,cntL;
      if(minTL2==TL+((TL-LL)*2) && cntT==0)
        {
         Alert(Symbol(),"حد دوم بالا یافت نشد");
         cntT=1;
        }
      if(minLL2==LL-((TL-LL)*2) && cntL==0)
        {
         Alert(Symbol(),"حد دوم پایین یافت نشد");
         cntL=1;
        }

      int z_star=q+1;
      int nz_star=q+1;
      double minTL2_star=TL+(600*_Point);
      double TL2_star;

      while(z_star<Bars(NULL,PERIOD_W1)-1)
        {
         if(ratesWeekly[z_star].high>(TL+(250*_Point)) && ratesWeekly[z_star].close<TL && ratesWeekly[z_star].open>LL && ratesWeekly[z_star].open<TL)
           {
            TL2_star=ratesWeekly[z_star].high;
            if(TL2_star<minTL2_star)minTL2_star=TL2_star;
           }
         z_star++;
        }

      int y_star=q+1;
      int ny_star=q+1;
      double minLL2_star=LL-(600*_Point);
      double LL2_star;
      while(y_star<Bars(NULL,PERIOD_W1)-1)
        {
         if(ratesWeekly[y_star].low<(LL-(250*_Point)) && ratesWeekly[y_star].close>LL && LL<ratesWeekly[y_star].open && ratesWeekly[y_star].open<TL)
           {
            LL2_star=ratesWeekly[y_star].low;
            if(LL2_star>minLL2_star)minLL2_star=LL2_star;
           }
         y_star++;
        }

      ObjectCreate  (0,"ML Start-"+q, OBJ_VLINE, 0,ratesWeekly[q].time+60*60*24*7,0);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger (0,"ML Start-"+q, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H4 | OBJ_PERIOD_H1 | OBJ_PERIOD_M30);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_COLOR,Black);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML Start-"+q,OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML Start-"+q,OBJPROP_SELECTABLE,true);


      ObjectCreate  (0,"ML End-"+q, OBJ_VLINE, 0,ratesWeekly[q].time+60*60*24*14,0);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_TIMEFRAMES, OBJ_PERIOD_H4 | OBJ_PERIOD_H1 | OBJ_PERIOD_M30);
      ObjectSetInteger (0,"ML End-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger (0,"ML End-"+q,OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_SELECTABLE,true);



      ObjectCreate(0,"ML starlineT",OBJ_HLINE,0,0,minTL2_star,0,0);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_WIDTH,0);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML starlineL",OBJ_HLINE,0,0,minLL2_star,0,0);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_WIDTH,0);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML TL",OBJ_HLINE,0,0,TL,0,0);
      ObjectSetInteger(0,"ML TL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML TL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML TL2",OBJ_HLINE,0,0,minTL2,0,0);
      ObjectSetInteger(0,"ML TL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML TL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL2",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML LL",OBJ_HLINE,0,0,LL,0,0);
      ObjectSetInteger(0,"ML LL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML LL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML LL2",OBJ_HLINE,0,0,minLL2,0,0);
      ObjectSetInteger(0,"ML LL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML LL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL2",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML TL",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"ML TL",OBJPROP_WIDTH,2);
      ObjectSetInteger(0,"ML TL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML LL",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"ML LL",OBJPROP_WIDTH,2);
      ObjectSetInteger(0,"ML LL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML TL2",OBJPROP_COLOR,Purple);
      ObjectSetInteger(0,"ML TL2",OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML TL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL2",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML LL2",OBJPROP_COLOR,Purple);
      ObjectSetInteger(0,"ML LL2",OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML LL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL2",OBJPROP_SELECTABLE,true);

      Firstinline=LL+((TL-LL)/3);
      Secondinline=LL+(2*(TL-LL)/3);

      ObjectCreate(0,"ML First 0.33",OBJ_HLINE,0,0,Firstinline,0,0);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML Second 0.33",OBJ_HLINE,0,0,Secondinline,0,0);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_SELECTABLE,true);
      ChartRedraw(0);

      int dir=0;
      string direction;
      int cntdir=0;
      int p=q+1;
      for(p=q+1;p<=20+q; p++)

        {
         if(ratesWeekly[p].open<ratesWeekly[q].low && cntdir==0)
           {
            direction="صعودی";
            dir=2;
            cntdir=1;
           }
         if(ratesWeekly[p].open>ratesWeekly[q].high && cntdir==0)
           {
            direction="نزولی";
            dir=0;
            cntdir=1;
           }
        }

      //-----------Jadval Tahlil 1   
      string tahlilA;
      string tahlilB;

      if(dir>1 && big>=1 && candletype=="تقاضا")
         tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي،شکست حد بال";
      if(dir>1 && big>=1 && candletype=="تقاضا")
         tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dir>1 && medium>=1 && candletype=="تقاضا")
         tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dir>1 && medium>=1 && candletype=="تقاضا")
         tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dir>1 && small>=1 && candletype=="تقاضا")
         tahlilA="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dir>1 && small>=1 && candletype=="تقاضا")
         tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dir>1 && spinning>=1 && candletype=="تقاضا")
         tahlilA="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dir>1 && spinning>=1 && candletype=="تقاضا")
         tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";

      if(dir<1 && big>=1 && candletype=="تقاضا")
         tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dir<1 && big>=1 && candletype=="تقاضا")
         tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dir<1 && medium>=1 && candletype=="تقاضا")
         tahlilA="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dir<1 && medium>=1 && candletype=="تقاضا")
         tahlilB="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dir<1 && small>=1 && candletype=="تقاضا")
         tahlilA="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dir<1 && small>=1 && candletype=="تقاضا")
         tahlilB="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";
      if(dir<1 && spinning>=1 && candletype=="تقاضا")
         tahlilA="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dir<1 && spinning>=1 && candletype=="تقاضا")
         tahlilB="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";

      if(dir>1 && big>=1 && candletype=="عرضه")
         tahlilA="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dir>1 && big>=1 && candletype=="عرضه")
         tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dir>1 && medium>=1 && candletype=="عرضه")
         tahlilA="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين ";
      if(dir>1 && medium>=1 && candletype=="عرضه")
         tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا ";
      if(dir>1 && small>=1 && candletype=="عرضه")
         tahlilA="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dir>1 && small>=1 && candletype=="عرضه")
         tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dir>1 && spinning>=1 && candletype=="عرضه")
         tahlilA="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dir>1 && spinning>=1 && candletype=="عرضه")
         tahlilB="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";

      if(dir<1 && big>=1 && candletype=="عرضه")
         tahlilA="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dir<1 && big>=1 && candletype=="عرضه")
         tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dir<1 && medium>=1 && candletype=="عرضه")
         tahlilA="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dir<1 && medium>=1 && candletype=="عرضه")
         tahlilB="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dir<1 && small>=1 && candletype=="عرضه")
         tahlilA="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dir<1 && small>=1 && candletype=="عرضه")
         tahlilB="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dir<1 && spinning>=1 && candletype=="عرضه")
         tahlilA="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dir<1 && spinning>=1 && candletype=="عرضه")
         tahlilB="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";

      ObjectCreate(0,"ML direction",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML direction",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML direction",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML direction",OBJPROP_YDISTANCE,20);
      ObjectSetString(0,"ML direction",OBJPROP_TEXT,direction);
      ObjectSetInteger(0,"ML direction",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML direction",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML direction",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML candletype",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML candletype",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML candletype",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML candletype",OBJPROP_YDISTANCE,35);
      ObjectSetString(0,"ML candletype",OBJPROP_TEXT,candletype);
      ObjectSetInteger(0,"ML candletype",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML candletype",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML candletype",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML X",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML X",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML X",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML X",OBJPROP_YDISTANCE,50);
      ObjectSetString(0,"ML X",OBJPROP_TEXT,X);
      ObjectSetInteger(0,"ML X",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML X",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML X",OBJPROP_SELECTABLE,true);

      Comment("   جهت اوليه","   ",direction,"\n","   نوع کندل","   ",candletype,"\n","   ","\n  اندازه بدنه کندل مورد ارزيابي:","   ",DoubleToString(badaneh,2),"\n","  اندازه سايه بالا","     ",DoubleToString(upshadow,2),"\n","  اندازه سايه پايين","    ",DoubleToString(downshadow,2),"\n","\n ميانگين دو بزرگترين کندل محيط","   ",DoubleToString((MaxBody+MaxBody2)/2,2),"\n   شماره بزرگترين کندل محيط:","   ",MaxN,"\n   شماره دومين کندل بزرگ محيط:","   ",MaxN2,"\n  نسبت بدنه کندل مورد ارزيابي به بدنه مبنا:","   ",DoubleToString(Totaldarsad,2),"\n","  نوع کندل","   ",X,"\n","\n","   حد احتياط بالا","   ",TL,"\n","   حد احتياط پايين","   ",LL,"\n","\n",tahlilA,"\n",tahlilB);
      //--- create timer
      EventSetTimer(7200);

     }

   if(typeofanalysis==3)
     {

      if(nOfCandleWmonthly>Bars(NULL,PERIOD_MN1))
        {
         Alert("تعداد کندل اشتباه است");
         return(-1);
        }

      double badanehmonthly=MathAbs((ratesMonthly[q].open-ratesMonthly[q].close)/_Point);

      if((ratesMonthly[q].open-ratesMonthly[q].close)>0)
         candletypemonthly="عرضه";
      if((ratesMonthly[q].close-ratesMonthly[q].open)>0)
         candletypemonthly="تقاضا";

      bool upshadowlenghtmonthly=0;
      bool downshadowlenghtmonthly=0;
      double upshadowmonthly=0;
      double downshadowmonthly=0;

      int nmonthly=q;
      int MaxNmonthly=q;
      double MaxBodymonthly=q;
      while(nmonthly<(nOfCandleWmonthly+q))
        {
         double Bodymonthly=((ratesMonthly[nmonthly].open-ratesMonthly[nmonthly].close)/_Point);
         double dymonthly=MathAbs(Bodymonthly);
         if(dymonthly>MaxBodymonthly)
           {
            MaxBodymonthly=dymonthly;
            MaxNmonthly=nmonthly;
           }
         nmonthly++;
        }

      int n2monthly=q;
      int MaxN2monthly=q;
      double MaxBody2monthly=q;
      while(n2monthly<(nOfCandleWmonthly+q))
        {
         double Body2monthly=((ratesMonthly[n2monthly].open-ratesMonthly[n2monthly].close)/_Point);
         double dy2monthly=MathAbs(Body2monthly);
         if(dy2monthly<MaxBodymonthly && dy2monthly>MaxBody2monthly)
           {
            MaxBody2monthly=dy2monthly;
            MaxN2monthly=n2monthly;
           }
         n2monthly++;
        }

      double darsadmonthly=(badanehmonthly/((MaxBodymonthly+MaxBody2monthly)/2))*100;
      double Totaldarsadmonthly=darsadmonthly;

      bool bigmonthly=0;
      bool mediummonthly=0;
      bool smallmonthly=0;
      bool spinningmonthly=0;
      string Xmonthly;

      if(Totaldarsadmonthly>=59)
         Xmonthly="بزرگ";
      if(Totaldarsadmonthly<59 && Totaldarsadmonthly>=39)
         Xmonthly="متوسط";
      if(Totaldarsadmonthly<39 && Totaldarsadmonthly>5)
         Xmonthly="کوچک";
      if(Totaldarsadmonthly<=5)
         Xmonthly="اسپينينگ";
      if(Totaldarsadmonthly>=59)
        {
         bigmonthly=1;
         candlesizemonthly=4;
        }
      if(Totaldarsadmonthly<59 && Totaldarsadmonthly>=39)
        {
         mediummonthly=1;
         candlesizemonthly=3;
        }
      if(Totaldarsadmonthly<39 && Totaldarsadmonthly>5)
        {
         smallmonthly=1;
         candlesizemonthly=2;
        }
      if(Totaldarsadmonthly<=5)
        {
         spinningmonthly=1;
         candlesizemonthly=1;
        }

      if(ratesMonthly[q].close>ratesMonthly[q].open)
        {
         upshadowmonthly=MathAbs((ratesMonthly[q].high-ratesMonthly[q].close+(1*_Point))/_Point);
         downshadowmonthly=MathAbs((ratesMonthly[q].open-ratesMonthly[q].low+(1*_Point))/_Point);
        }
      if(ratesMonthly[q].close<ratesMonthly[q].open)
        {
         upshadowmonthly=MathAbs((ratesMonthly[q].high-ratesMonthly[q].open+(1 *_Point))/_Point);
         downshadowmonthly=MathAbs((ratesMonthly[q].close-ratesMonthly[q].low+(1 *_Point))/_Point);
        }

      if(upshadowmonthly>0.003 && upshadowmonthly>(1.5*(badanehmonthly)) && candlesizemonthly<3)
         upshadowlenghtmonthly=1;
      if(upshadowmonthly>0.003 && upshadowmonthly>(1*(badanehmonthly)) && candlesizemonthly>=3)
         upshadowlenghtmonthly=1;

      if(downshadowmonthly>0.003 && downshadowmonthly>(1.5*(badanehmonthly)) && candlesizemonthly<3)
         downshadowlenghtmonthly=1;
      if(downshadowmonthly>0.003 && downshadowmonthly>(1*(badanehmonthly)) && candlesizemonthly>=3)
         downshadowlenghtmonthly=1;

      if(upshadowlenghtmonthly==1 && downshadowlenghtmonthly==1 && 0.9<(upshadowmonthly/downshadowmonthly) && (upshadowmonthly/downshadowmonthly)<1.1)
        {
         Comment(upshadowmonthly/downshadowmonthly);
         Alert("This Month is doubtfull , its better to wait for next Month on this symbol");
         return(-1);
        }

      if(bigmonthly>=1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high;
      if(bigmonthly>=1 && ratesMonthly[q].close>ratesMonthly[q].open)
         LLmonthly=(ratesMonthly[q].open+(0.75*(badanehmonthly*_Point)));

      if(upshadowlenghtmonthly==1 && bigmonthly>=1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high-(0.5*(upshadowmonthly*_Point));

      if(bigmonthly>=1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low;
      if(bigmonthly>=1 && ratesMonthly[q].close<ratesMonthly[q].open)
         TLmonthly=(ratesMonthly[q].close+(0.25*(badanehmonthly*_Point)));
      if(downshadowlenghtmonthly==1 && bigmonthly>=1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low+(0.5*(downshadowmonthly*_Point));

      if(mediummonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low;
      if(mediummonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         TLmonthly=(ratesMonthly[q].close+(0.5*(badanehmonthly*_Point)));

      if(downshadowlenghtmonthly==1 && mediummonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low+(0.5*(downshadowmonthly*_Point));

      if(mediummonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high;
      if(mediummonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         LLmonthly=(ratesMonthly[q].open+(0.5*(badanehmonthly*_Point)));

      if(upshadowlenghtmonthly==1 && mediummonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high -(0.5*(upshadowmonthly*_Point));

      if(smallmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high;
      if(smallmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low;

      if(upshadowlenghtmonthly==1 && smallmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high -(0.5*(upshadowmonthly*_Point));
      if(downshadowlenghtmonthly==1 && smallmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low+(0.5*(downshadowmonthly*_Point));

      if(smallmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low;
      if(smallmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high;

      if(downshadowlenghtmonthly==1 && smallmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].close-(0.5*(downshadowmonthly*_Point));
      if(upshadowlenghtmonthly==1 && smallmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].open+(0.5*(upshadowmonthly*_Point));

      if(spinningmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high;
      if(spinningmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low;

      if(spinningmonthly==1 && upshadowlenghtmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high -(0.5*(upshadowmonthly*_Point));
      if(spinningmonthly==1 && downshadowlenghtmonthly==1 && ratesMonthly[q].close>ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low+(0.5*(downshadowmonthly*_Point));

      if(spinningmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].low;
      if(spinningmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].high;

      if(spinningmonthly==1 && downshadowlenghtmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         LLmonthly=ratesMonthly[q].close-(0.5*(downshadowmonthly*_Point));
      if(spinningmonthly==1 && upshadowlenghtmonthly==1 && ratesMonthly[q].close<ratesMonthly[q].open)
         TLmonthly=ratesMonthly[q].open+(0.5*(upshadowmonthly*_Point));

      double MinLimitmonthly=TLmonthly;
      if(candlesizemonthly==4) MinLimitmonthly=MinRateBmonthly*(((NormalizeDouble(TLmonthly,_Digits)-NormalizeDouble(LLmonthly,_Digits)))/6);
      if(candlesizemonthly==3) MinLimitmonthly=MinRateMmonthly*(((NormalizeDouble(TLmonthly,_Digits)-NormalizeDouble(LLmonthly,_Digits)))/6);
      if(candlesizemonthly==2) MinLimitmonthly=MinRateSmonthly*(((NormalizeDouble(TLmonthly,_Digits)-NormalizeDouble(LLmonthly,_Digits)))/6);
      if(candlesizemonthly==1) MinLimitmonthly=MinRateSPmonthly*(((NormalizeDouble(TLmonthly,_Digits)-NormalizeDouble(LLmonthly,_Digits)))/6);

      double safetylimitUmonthly=MathMax((TLmonthly+(MinLimit2monthly*_Point)),(TLmonthly+MinLimitmonthly));
      double safetylimitDmonthly=MathMin((LLmonthly-(MinLimit2monthly*_Point)),(LLmonthly-MinLimitmonthly));

      int zmonthly=q;
      int nzmonthly=q;
      minTL2monthly=TLmonthly+((TLmonthly-LLmonthly)*2);
      minLL2monthly=LLmonthly-((TLmonthly-LLmonthly)*2);
      int countmonthly=0;
      bool mohitimonthly;
      double Bodyzmonthly;
      double upshadowzmonthly;
      double downshadowzmonthly;


      while(zmonthly<(Bars(NULL,PERIOD_MN1)-1) && countmonthly<=MaxTPSLCalcmonthly && countmonthly<=Bars(NULL,PERIOD_MN1)-2-zmonthly)
        {
        
           {
            if(ratesMonthly[zmonthly].high>LLmonthly && ratesMonthly[zmonthly].low<TLmonthly)
              {
               mohitimonthly=1;
               countmonthly++;
               ObjectCreate(0,"ML MohitiTW-"+zmonthly,OBJ_ARROW_UP,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].low);
               ObjectSetInteger(0,"ML MohitiTW-"+zmonthly,OBJPROP_COLOR,Purple);
               ObjectSetInteger(0,"ML MohitiTW-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
               ObjectSetInteger(0,"ML MohitiTW-"+zmonthly,OBJPROP_HIDDEN,false);
               ObjectSetInteger(0,"ML MohitiTW-"+zmonthly,OBJPROP_SELECTABLE,true);
               ChartRedraw(0);
              }
            else mohitimonthly=0;
           
           }

         if(mohitimonthly==1)
           {
            if((ratesMonthly[zmonthly].high>TLmonthly && ratesMonthly[zmonthly].open<TLmonthly))
              {

               if(ratesMonthly[zmonthly].close>ratesMonthly[zmonthly].open)
                 {
                  upshadowzmonthly=MathAbs((ratesMonthly[zmonthly].high-ratesMonthly[zmonthly].close+(1*_Point))/_Point);
                 }
               if(ratesMonthly[zmonthly].close<ratesMonthly[zmonthly].open)
                 {
                  upshadowzmonthly=MathAbs((ratesMonthly[zmonthly].high-ratesMonthly[zmonthly].open+(1*_Point))/_Point);
                 }

               Bodyzmonthly=MathAbs(ratesMonthly[zmonthly].close-ratesMonthly[zmonthly].open)/_Point;
               int nTL2monthly=zmonthly;
               int MaxNTL2monthly=zmonthly;
               double MaxBodyTL2monthly=zmonthly;

               while(nTL2monthly<(nOfCandleWmonthly+zmonthly) && nTL2monthly<Bars(NULL,PERIOD_MN1)-q-1 )
                 {
                  double BodyTL2monthly=((ratesMonthly[nTL2monthly].open-ratesMonthly[nTL2monthly].close)/_Point);
                  double dyTL2monthly=MathAbs(BodyTL2monthly);
                  if(dyTL2monthly>MaxBodyTL2monthly)
                    {
                     MaxBodyTL2monthly=dyTL2monthly;
                     MaxNTL2monthly=nTL2monthly;
                    }
                  nTL2monthly++;
                 }

               int n2TL2monthly=zmonthly;
               int MaxN2TL2monthly=zmonthly;
               double MaxBody2TL2monthly=zmonthly;
               while(n2TL2monthly<(nOfCandleWmonthly+zmonthly)&& nTL2monthly<Bars(NULL,PERIOD_MN1)-q-1)
                 {
                  double Body2TL2monthly=((ratesMonthly[n2TL2monthly].open-ratesMonthly[n2TL2monthly].close)/_Point);
                  double dy2TL2monthly=MathAbs(Body2TL2monthly);
                  if(dy2TL2monthly<MaxBodyTL2monthly && dy2TL2monthly>MaxBody2TL2monthly)
                    {
                     MaxBody2TL2monthly=dy2TL2monthly;
                     MaxN2TL2monthly=n2TL2monthly;
                    }
                  n2TL2monthly++;
                 }

               double darsadTL2monthly=(Bodyzmonthly/((MaxBodyTL2monthly+MaxBody2TL2monthly)/2))*100;

               double candlesizeTL2monthly;
               if(darsadTL2monthly>=59)
                  candlesizeTL2monthly=4;
               if(darsadTL2monthly<59 && darsadTL2monthly>=39)
                  candlesizeTL2monthly=3;
               if(darsadTL2monthly<39 && darsadTL2monthly>5)
                  candlesizeTL2monthly=2;
               if(darsadTL2monthly<=5)
                  candlesizeTL2monthly=1;

               if(ratesMonthly[zmonthly].close<TLmonthly && candlesizeTL2monthly>=3 && upshadowzmonthly>=Bodyzmonthly && ratesMonthly[zmonthly].high>(TLmonthly+(MinLimitmonthly)))
                 {
                  TL2monthly=ratesMonthly[zmonthly].high;
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate(0,"ML TL2 Candid W1-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesMonthly[zmonthly].close<TLmonthly && candlesizeTL2monthly<3 && upshadowzmonthly>=(2*Bodyzmonthly) && ratesMonthly[zmonthly].high>(TLmonthly+(MinLimitmonthly)))
                 {
                  TL2monthly=ratesMonthly[zmonthly].high;
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate(0,"ML TL2 Candid W2-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesMonthly[zmonthly].close<TLmonthly && candlesizeTL2monthly>=3 && ratesMonthly[zmonthly].high>(TLmonthly+(MinLimitmonthly)) && (ratesMonthly[zmonthly].close<ratesMonthly[zmonthly].open))
                 {
                  TL2monthly=ratesMonthly[zmonthly].high;
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate(0,"ML TL2 Candid W3-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(zmonthly>q && ratesMonthly[zmonthly].close>TLmonthly && candlesizeTL2monthly>=3 && ratesMonthly[zmonthly].high>(TLmonthly+(MinLimitmonthly)) && ratesMonthly[zmonthly-1].low<(ratesMonthly[zmonthly].close-(0.45*(ratesMonthly[zmonthly].close-ratesMonthly[zmonthly].open))))
                 {
                  TL2monthly=MathMax(ratesMonthly[zmonthly].high,ratesMonthly[zmonthly-1].high);
                  if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                  ObjectCreate(0,"ML TL2 Candid W4-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zmonthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

              }

            if(((ratesMonthly[zmonthly].low<LLmonthly && ratesMonthly[zmonthly].open>LLmonthly)))
              {

               if(ratesMonthly[zmonthly].close>ratesMonthly[zmonthly].open)
                 {
                  downshadowzmonthly=MathAbs((ratesMonthly[zmonthly].low-ratesMonthly[zmonthly].open+(1*_Point))/_Point);
                 }
               if(ratesMonthly[zmonthly].close<ratesMonthly[zmonthly].open)
                 {
                  downshadowzmonthly=MathAbs((ratesMonthly[zmonthly].low-ratesMonthly[zmonthly].close+(1*_Point))/_Point);
                 }

               Bodyzmonthly=MathAbs(ratesMonthly[zmonthly].close-ratesMonthly[zmonthly].open)/_Point;
               int nLL2monthly=zmonthly;
               int MaxNLL2monthly=zmonthly;
               double MaxBodyLL2monthly=zmonthly;
               while(nLL2monthly<(nOfCandleWmonthly+zmonthly) && nLL2monthly<Bars(NULL,PERIOD_MN1)-q-1)
                 {
                  double BodyLL2monthly=((ratesMonthly[nLL2monthly].open-ratesMonthly[nLL2monthly].close)/_Point);
                  double dyLL2monthly=MathAbs(BodyLL2monthly);
                  if(dyLL2monthly>MaxBodyLL2monthly)
                    {
                     MaxBodyLL2monthly=dyLL2monthly;
                     MaxNLL2monthly=nLL2monthly;
                    }
                  nLL2monthly++;
                 }

               int n2LL2monthly=zmonthly;
               int MaxN2LL2monthly=zmonthly;
               double MaxBody2LL2monthly=zmonthly;
               while(n2LL2monthly<(nOfCandleWmonthly+zmonthly) && n2LL2monthly<Bars(NULL,PERIOD_MN1)-q-1)
                 {
                  double Body2LL2monthly=((ratesMonthly[n2LL2monthly].open-ratesMonthly[n2LL2monthly].close)/_Point);
                  double dy2LL2monthly=MathAbs(Body2LL2monthly);
                  if(dy2LL2monthly<MaxBodyLL2monthly && dy2LL2monthly>MaxBody2LL2monthly)
                    {
                     MaxBody2LL2monthly=dy2LL2monthly;
                     MaxN2LL2monthly=n2LL2monthly;
                    }
                  n2LL2monthly++;
                 }

               double darsadLL2monthly=(Bodyzmonthly/((MaxBodyLL2monthly+MaxBody2LL2monthly)/2))*100;

               double candlesizeLL2monthly;
               if(darsadLL2monthly>=59)
                  candlesizeLL2monthly=4;
               if(darsadLL2monthly<59 && darsadLL2monthly>=39)
                  candlesizeLL2monthly=3;
               if(darsadLL2monthly<39 && darsadLL2monthly>5)
                  candlesizeLL2monthly=2;
               if(darsadLL2monthly<=5)
                  candlesizeLL2monthly=1;

               if(ratesMonthly[zmonthly].close>LLmonthly && candlesizeLL2monthly>=3 && downshadowzmonthly>=Bodyzmonthly && ratesMonthly[zmonthly].low<(LLmonthly-(MinLimitmonthly)))
                 {
                  LL2monthly=ratesMonthly[zmonthly].low;
                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate(0,"ML LL2 Candid W1-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesMonthly[zmonthly].close>LLmonthly && candlesizeLL2monthly<3 && downshadowzmonthly>=(2*Bodyzmonthly) && ratesMonthly[zmonthly].low<(LLmonthly-(MinLimitmonthly)))
                 {
                  LL2monthly=ratesMonthly[zmonthly].low;
                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate(0,"ML LL2 Candid W2-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesMonthly[zmonthly].close>LLmonthly && candlesizeLL2monthly>=3 && ratesMonthly[zmonthly].low<(LLmonthly-(MinLimitmonthly)) && (ratesMonthly[zmonthly].close>ratesMonthly[zmonthly].open))
                 {
                  LL2monthly=ratesMonthly[zmonthly].low;
                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate(0,"ML LL2 Candid W3-"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(zmonthly>q && ratesMonthly[zmonthly].close<LLmonthly && candlesizeLL2monthly>=3 && ratesMonthly[zmonthly].low<(LLmonthly-(MinLimitmonthly)) && ratesMonthly[zmonthly-1].high>(ratesMonthly[zmonthly].close+(0.45*(ratesMonthly[zmonthly].open-ratesMonthly[zmonthly].close))))
                 {
                  LL2monthly=MathMin(ratesMonthly[zmonthly].low,ratesMonthly[zmonthly-1].low);
                  if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                  ObjectCreate(0,"ML LL2 Candid W4"+zmonthly,OBJ_VLINE,0,ratesMonthly[zmonthly].time,ratesMonthly[zmonthly].open);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zmonthly,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zmonthly,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zmonthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zmonthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

              }
           }
         zmonthly++;
         ChartRedraw(0);
        }

      if(minTL2monthly==TLmonthly+((TLmonthly-LLmonthly)*2))
        {
         int shoroTmonthly=iBarShift(NULL,PERIOD_W1,ratesMonthly[q].time);
         ObjectCreate(0,"ML ShoroTD1-"+shoroTmonthly,OBJ_VLINE,0,ratesWeekly[shoroTmonthly-1].time,0);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTmonthly,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTmonthly,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTmonthly,OBJPROP_SELECTABLE,true);
         ChartRedraw(0);

         int z2monthly=shoroTmonthly;
         int nz2monthly=shoroTmonthly;
         int count2monthly=0;
         bool mohiti2monthly;
         double Bodyz2monthly;
         double upshadowz2monthly;

         while(z2monthly<(Bars(NULL,PERIOD_W1)-1) && count2monthly<=MaxTPSLCalcmonthly && count2monthly<=Bars(NULL,PERIOD_W1)-2-z2monthly)
           {
              {
               if(ratesWeekly[z2monthly].high>LLmonthly && ratesWeekly[z2monthly].low<TLmonthly)
                 {
                  mohiti2monthly=1;
                  count2monthly++;
                  ObjectCreate(0,"ML MohitiTD1T-"+z2monthly,OBJ_ARROW_UP,0,ratesWeekly[z2monthly].time,ratesWeekly[z2monthly].low);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2monthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2monthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2monthly,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }
               else mohiti2monthly=0;
              }

            if(mohiti2monthly==1)
              {
               if((ratesWeekly[z2monthly].high>TLmonthly && ratesWeekly[z2monthly].open<TLmonthly))
                 {
                  if(ratesWeekly[z2monthly].close>ratesWeekly[z2monthly].open)
                    {
                     upshadowz2monthly=MathAbs((ratesWeekly[z2monthly].high-ratesWeekly[z2monthly].close+(1*_Point))/_Point);
                    }
                  if(ratesWeekly[z2monthly].close<ratesWeekly[z2monthly].open)
                    {
                     upshadowz2monthly=MathAbs((ratesWeekly[z2monthly].high-ratesWeekly[z2monthly].open+(1*_Point))/_Point);
                    }

                  Bodyz2monthly=MathAbs(ratesWeekly[z2monthly].close-ratesWeekly[z2monthly].open)/_Point;
                  int nTL22monthly=z2monthly;
                  int MaxNTL22monthly=z2monthly;
                  double MaxBodyTL22monthly=z2monthly;
                  while(nTL22monthly<(nOfCandleWmonthly+z2monthly)&& nTL22monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double BodyTL22monthly=((ratesWeekly[nTL22monthly].open-ratesWeekly[nTL22monthly].close)/_Point);
                     double dyTL22monthly=MathAbs(BodyTL22monthly);
                     if(dyTL22monthly>MaxBodyTL22monthly)
                       {
                        MaxBodyTL22monthly=dyTL22monthly;
                        MaxNTL22monthly=nTL22monthly;
                       }
                     nTL22monthly++;
                    }

                  int n2TL22monthly=z2monthly;
                  int MaxN2TL22monthly=z2monthly;
                  double MaxBody2TL22monthly=z2monthly;
                  while(n2TL22monthly<(nOfCandleWmonthly+z2monthly)&& n2TL22monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double Body2TL22monthly=((ratesWeekly[n2TL22monthly].open-ratesWeekly[n2TL22monthly].close)/_Point);
                     double dy2TL22monthly=MathAbs(Body2TL22monthly);
                     if(dy2TL22monthly<MaxBodyTL22monthly && dy2TL22monthly>MaxBody2TL22monthly)
                       {
                        MaxBody2TL22monthly=dy2TL22monthly;
                        MaxN2TL22monthly=n2TL22monthly;
                       }
                     n2TL22monthly++;
                    }

                  double darsadTL22monthly=(Bodyz2monthly/((MaxBodyTL22monthly+MaxBody2TL22monthly)/2))*100;

                  double candlesizeTL22monthly;
                  if(darsadTL22monthly>=59)
                     candlesizeTL22monthly=4;
                  if(darsadTL22monthly<59 && darsadTL22monthly>=39)
                     candlesizeTL22monthly=3;
                  if(darsadTL22monthly<39 && darsadTL22monthly>5)
                     candlesizeTL22monthly=2;
                  if(darsadTL22monthly<=5)
                     candlesizeTL22monthly=1;

                  if(ratesWeekly[z2monthly].close<TLmonthly && candlesizeTL22monthly>=3 && upshadowz2monthly>=Bodyz2monthly && ratesWeekly[z2monthly].high>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=ratesWeekly[z2monthly].high;
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid D11-"+z2monthly,OBJ_VLINE,0,ratesWeekly[z2monthly].time,ratesWeekly[z2monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2monthly,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(ratesWeekly[z2monthly].close<TLmonthly && candlesizeTL22monthly<3 && upshadowz2monthly>=(2*Bodyz2monthly) && ratesWeekly[z2monthly].high>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=ratesWeekly[z2monthly].high;
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid D12-"+z2monthly,OBJ_VLINE,0,ratesWeekly[z2monthly].time,ratesWeekly[z2monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2monthly,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(ratesWeekly[z2monthly].close<TLmonthly && candlesizeTL22monthly>=3 && ratesWeekly[z2monthly].high>(TLmonthly+(MinLimitmonthly)) && (ratesWeekly[z2monthly].close<ratesWeekly[z2monthly].open))
                    {
                     TL2monthly=ratesWeekly[z2monthly].high;
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid D13-"+z2monthly,OBJ_VLINE,0,ratesWeekly[z2monthly].time,ratesWeekly[z2monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2monthly,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(z2monthly>shoroTmonthly && ratesWeekly[z2monthly].close>TLmonthly && candlesizeTL22monthly>=3 && ratesWeekly[z2monthly].high>(TLmonthly+(MinLimitmonthly)) && ratesWeekly[z2monthly-1].low<(ratesWeekly[z2monthly].close-(0.45*(ratesWeekly[z2monthly].close-ratesWeekly[z2monthly].open))))
                    {
                     TL2monthly=MathMax(ratesWeekly[z2monthly].high,ratesWeekly[z2monthly-1].high);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid D14-"+z2monthly,OBJ_VLINE,0,ratesWeekly[z2monthly].time,ratesWeekly[z2monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2monthly,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                 }

              }
            z2monthly++;
           }
         ChartRedraw(0);

        }

      if(minTL2monthly==TLmonthly+((TLmonthly-LLmonthly)*2))
        {
         int shoroT2monthly=iBarShift(NULL,PERIOD_D1,ratesMonthly[q].time);
         ObjectCreate(0,"ML shoroTH4T-"+shoroT2monthly,OBJ_VLINE,0,ratesWeekly[shoroT2monthly-1].time,ratesDaily[shoroT2monthly-1].low);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2monthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2monthly,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2monthly,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2monthly,OBJPROP_SELECTABLE,true);

         int z4monthly=shoroT2monthly;
         int nz4monthly=shoroT2monthly;
         int count4monthly=0;
         bool mohiti4monthly;
         double Bodyz4monthly;
         double upshadowz4monthly;

         while(z4monthly<(Bars(NULL,PERIOD_D1)-1) && count4monthly<=MaxTPSLCalcmonthly && count4monthly<=Bars(NULL,PERIOD_D1)-2-z4monthly)
           {
              {
               if(ratesDaily[z4monthly].high>LLmonthly && ratesDaily[z4monthly].low<TLmonthly)
                 {
                  mohiti4monthly=1;
                  count4monthly++;
                  ObjectCreate(0,"ML MohitiTH4T-"+z4monthly,OBJ_ARROW,0,ratesDaily[z4monthly].time,ratesDaily[z4monthly].low);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4monthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4monthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4monthly,OBJPROP_SELECTABLE,true);
                 }
               else mohiti4monthly=0;
              }

            if(mohiti4monthly==1)
              {
               if((ratesDaily[z4monthly].high>TLmonthly && ratesDaily[z4monthly].open<TLmonthly))
                 {
                  if(ratesDaily[z4monthly].close>ratesDaily[z4monthly].open)
                    {
                     upshadowz4monthly=MathAbs((ratesDaily[z4monthly].high-ratesDaily[z4monthly].close+(1*_Point))/_Point);
                    }
                  if(ratesDaily[z4monthly].close<ratesDaily[z4monthly].open)
                    {
                     upshadowz4monthly=MathAbs((ratesDaily[z4monthly].high-ratesDaily[z4monthly].open+(1*_Point))/_Point);
                    }

                  Bodyz4monthly=MathAbs(ratesDaily[z4monthly].close-ratesDaily[z4monthly].open)/_Point;
                  int nTL24monthly=z4monthly;
                  int MaxNTL24monthly=z4monthly;
                  double MaxBodyTL24monthly=z4monthly;
                  while(nTL24monthly<(nOfCandleWmonthly+z4monthly)&& nTL24monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double BodyTL24monthly=((ratesDaily[nTL24monthly].open-ratesDaily[nTL24monthly].close)/_Point);
                     double dyTL24monthly=MathAbs(BodyTL24monthly);
                     if(dyTL24monthly>MaxBodyTL24monthly)
                       {
                        MaxBodyTL24monthly=dyTL24monthly;
                        MaxNTL24monthly=nTL24monthly;
                       }
                     nTL24monthly++;
                    }

                  int n2TL24monthly=z4monthly;
                  int MaxN2TL24monthly=z4monthly;
                  double MaxBody2TL24monthly=z4monthly;
                  while(n2TL24monthly<(nOfCandleWmonthly+z4monthly)&& n2TL24monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double Body2TL24monthly=((ratesDaily[n2TL24monthly].open-ratesDaily[nTL24monthly].close)/_Point);
                     double dy2TL24monthly=MathAbs(Body2TL24monthly);
                     if(dy2TL24monthly<MaxBodyTL24monthly && dy2TL24monthly>MaxBody2TL24monthly)
                       {
                        MaxBody2TL24monthly=dy2TL24monthly;
                        MaxN2TL24monthly=n2TL24monthly;
                       }
                     n2TL24monthly++;
                    }

                  double darsadTL24monthly=(Bodyz4monthly/((MaxBodyTL24monthly+MaxBody2TL24monthly)/2))*100;

                  double candlesizeTL24monthly;
                  if(darsadTL24monthly>=61)
                     candlesizeTL24monthly=4;
                  if(darsadTL24monthly<61 && darsadTL24monthly>=41)
                     candlesizeTL24monthly=3;
                  if(darsadTL24monthly<41 && darsadTL24monthly>5)
                     candlesizeTL24monthly=2;
                  if(darsadTL24monthly<=5)
                     candlesizeTL24monthly=1;

                  if(ratesDaily[z4monthly].close<TLmonthly && candlesizeTL24monthly>=3 && upshadowz4monthly>=Bodyz4monthly && ratesDaily[z4monthly].high>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=ratesDaily[z4monthly].high;
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid H41-"+z4monthly,OBJ_VLINE,0,ratesDaily[z4monthly].time,ratesDaily[z4monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z4monthly].close<TLmonthly && candlesizeTL24monthly<3 && upshadowz4monthly>=(2*Bodyz4monthly) && ratesDaily[z4monthly].high>(TLmonthly+(MinLimitmonthly)))
                    {
                     TL2monthly=ratesDaily[z4monthly].high;
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid H42-"+z4monthly,OBJ_VLINE,0,ratesDaily[z4monthly].time,ratesDaily[z4monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z4monthly].close<TLmonthly && candlesizeTL24monthly>=3 && ratesDaily[z4monthly].high>(TLmonthly+(MinLimitmonthly)) && (ratesDaily[z4monthly].close<ratesDaily[z4monthly].open))
                    {
                     TL2monthly=ratesDaily[z4monthly].high;
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid H43-"+z4monthly,OBJ_VLINE,0,ratesDaily[z4monthly].time,ratesDaily[z4monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(z4monthly>shoroT2monthly && ratesDaily[z4monthly].close>TLmonthly && candlesizeTL24monthly>=3 && ratesDaily[z4monthly].high>(TLmonthly+(MinLimitmonthly)) && ratesDaily[z4monthly-1].low<(ratesDaily[z4monthly].close-(0.45*(ratesDaily[z4monthly].close-ratesDaily[z4monthly].open))))
                    {
                     TL2monthly=MathMax(ratesDaily[z4monthly].high,ratesDaily[z4monthly-1].high);
                     if(TL2monthly<minTL2monthly)minTL2monthly=TL2monthly;
                     ObjectCreate(0,"ML TL2 Candid H44-"+z4monthly,OBJ_VLINE,0,ratesDaily[z4monthly].time,ratesDaily[z4monthly].open);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4monthly,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4monthly,OBJPROP_SELECTABLE,true);
                    }

                 }

              }
            z4monthly++;
           }
         ChartRedraw(0);

        }

      if(minLL2monthly==LLmonthly-((TLmonthly-LLmonthly)*2))
        {
         int shoroLmonthly=iBarShift(NULL,PERIOD_W1,ratesMonthly[q].time);
         ObjectCreate(0,"ML shoroLD1-"+shoroLmonthly,OBJ_VLINE,0,ratesWeekly[shoroLmonthly-1].time,ratesWeekly[shoroLmonthly-1].time);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLmonthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLmonthly,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLmonthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLmonthly,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLmonthly,OBJPROP_SELECTABLE,true);

         int z3monthly=shoroLmonthly;
         int nz3monthly=shoroLmonthly;
         int count3monthly=0;
         bool mohiti3monthly;
         double Bodyz3monthly;
         double downshadowz3monthly;

         while(z3monthly<Bars(NULL,PERIOD_W1)-1 && count3monthly<=MaxTPSLCalcmonthly && count3monthly<=Bars(NULL,PERIOD_W1)-2-z3monthly)
           {
              {
               if(ratesWeekly[z3monthly].high>LLmonthly && ratesWeekly[z3monthly].low<TLmonthly)
                 {
                  mohiti3monthly=1;
                  count3monthly++;
                  ObjectCreate(0,"ML MohitiTD1L-"+z3monthly,OBJ_ARROW,0,ratesWeekly[z3monthly].time,ratesWeekly[z3monthly].low);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3monthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3monthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3monthly,OBJPROP_SELECTABLE,true);
                 }
               else mohiti3monthly=0;
              }

            if(mohiti3monthly==1)
              {

               if(((ratesWeekly[z3monthly].low<LLmonthly && ratesWeekly[z3monthly].open>LLmonthly)))
                 {

                  if(ratesWeekly[z3monthly].close>ratesWeekly[z3monthly].open)
                    {
                     downshadowz3monthly=MathAbs((ratesWeekly[z3monthly].low-ratesWeekly[z3monthly].open+(1*_Point))/_Point);
                    }
                  if(ratesWeekly[z3monthly].close<ratesWeekly[z3monthly].open)
                    {
                     downshadowz3monthly=MathAbs((ratesWeekly[z3monthly].low-ratesWeekly[z3monthly].close+(1*_Point))/_Point);
                    }

                  Bodyz3monthly=MathAbs(ratesWeekly[z3monthly].close-ratesWeekly[z3monthly].open)/_Point;
                  int nLL23monthly=z3monthly;
                  int MaxNLL23monthly=z3monthly;
                  double MaxBodyLL23monthly=z3monthly;

                  while(nLL23monthly<(nOfCandleWmonthly+z3monthly)&& nLL23monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double BodyLL23monthly=((ratesWeekly[nLL23monthly].open-ratesWeekly[nLL23monthly].close)/_Point);
                     double dyLL23monthly=MathAbs(BodyLL23monthly);
                     if(dyLL23monthly>MaxBodyLL23monthly)
                       {
                        MaxBodyLL23monthly=dyLL23monthly;
                        MaxNLL23monthly=nLL23monthly;
                       }
                     nLL23monthly++;
                    }

                  int n2LL23monthly=z3monthly;
                  int MaxN2LL23monthly=z3monthly;
                  double MaxBody2LL23monthly=z3monthly;
                  while(n2LL23monthly<(nOfCandleWmonthly+z3monthly)&& n2LL23monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double Body2LL23monthly=((ratesWeekly[n2LL23monthly].open-ratesWeekly[n2LL23monthly].close)/_Point);
                     double dy2LL23monthly=MathAbs(Body2LL23monthly);
                     if(dy2LL23monthly<MaxBodyLL23monthly && dy2LL23monthly>MaxBody2LL23monthly)
                       {
                        MaxBody2LL23monthly=dy2LL23monthly;
                        MaxN2LL23monthly=n2LL23monthly;
                       }
                     n2LL23monthly++;
                    }

                  double darsadLL23monthly=(Bodyz3monthly/((MaxBodyLL23monthly+MaxBody2LL23monthly)/2))*100;

                  double candlesizeLL23monthly;
                  if(darsadLL23monthly>=59)
                     candlesizeLL23monthly=4;
                  if(darsadLL23monthly<59 && darsadLL23monthly>=39)
                     candlesizeLL23monthly=3;
                  if(darsadLL23monthly<39 && darsadLL23monthly>5)
                     candlesizeLL23monthly=2;
                  if(darsadLL23monthly<=5)
                     candlesizeLL23monthly=1;

                  if(ratesWeekly[z3monthly].close>LLmonthly && candlesizeLL23monthly>=3 && downshadowz3monthly>=Bodyz3monthly && ratesWeekly[z3monthly].low<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=ratesWeekly[z3monthly].low;
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LD11-"+z3monthly,OBJ_VLINE,0,ratesWeekly[z3monthly].time,ratesWeekly[z3monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesWeekly[z3monthly].close>LLmonthly && candlesizeLL23monthly<3 && downshadowz3monthly>=(2*Bodyz3monthly) && ratesWeekly[z3monthly].low<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=ratesWeekly[z3monthly].low;
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LD12-"+z3monthly,OBJ_VLINE,0,ratesWeekly[z3monthly].time,ratesWeekly[z3monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesWeekly[z3monthly].close>LLmonthly && candlesizeLL23monthly>=3 && ratesWeekly[z3monthly].low<(LLmonthly-(MinLimitmonthly)) && (ratesWeekly[z3monthly].close>ratesWeekly[z3monthly].open))
                    {
                     LL2monthly=ratesWeekly[z3monthly].low;
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LD13-"+z3monthly,OBJ_VLINE,0,ratesWeekly[z3monthly].time,ratesWeekly[z3monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(z3monthly>shoroLmonthly && ratesWeekly[z3monthly].close<LLmonthly && candlesizeLL23monthly>=3 && ratesWeekly[z3monthly].low<(LLmonthly-(MinLimitmonthly)) && ratesWeekly[z3monthly-1].high>(ratesWeekly[z3monthly].close+(0.45*(ratesWeekly[z3monthly].open-ratesWeekly[z3monthly].close))))
                    {
                     LL2monthly=MathMin(ratesWeekly[z3monthly].low,ratesWeekly[z3monthly-1].low);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LD14-"+z3monthly,OBJ_VLINE,0,ratesWeekly[z3monthly].time,ratesWeekly[z3monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_W1);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3monthly,OBJPROP_SELECTABLE,true);
                    }

                 }
              }
            z3monthly++;
           }

        }

      if(minLL2monthly==LLmonthly-((TLmonthly-LLmonthly)*2))
        {
         int shoroL2monthly=iBarShift(NULL,PERIOD_D1,ratesMonthly[q].time);
         ObjectCreate(0,"ML shoroLH4L-"+shoroL2monthly,OBJ_VLINE,0,ratesDaily[shoroL2monthly-1].time,ratesDaily[shoroL2monthly-1].low);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2monthly,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2monthly,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2monthly,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2monthly,OBJPROP_SELECTABLE,true);

         int z5monthly=shoroL2monthly;
         int nz5monthly=shoroL2monthly;
         int count5monthly=0;
         bool mohiti5monthly;
         double Bodyz5monthly;
         double downshadowz5monthly;

         while(z5monthly<(Bars(NULL,PERIOD_D1)-1) && count5monthly<=MaxTPSLCalcmonthly && count5monthly<Bars(NULL,PERIOD_D1)-2-z5monthly)
           {
              {
               if(ratesDaily[z5monthly].high>LLmonthly && ratesDaily[z5monthly].low<TLmonthly)
                 {
                  mohiti5monthly=1;
                  count5monthly++;
                  ObjectCreate(0,"ML MohitiTH4-"+z5monthly,OBJ_ARROW,0,ratesDaily[z5monthly].time,ratesDaily[z5monthly].low);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5monthly,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5monthly,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5monthly,OBJPROP_SELECTABLE,true);
                 }
               else mohiti5monthly=0;
              }

            if(mohiti5monthly==1)
              {

               if(ratesDaily[z5monthly].low<LLmonthly && ratesDaily[z5monthly].open>LLmonthly)
                 {

                  if(ratesDaily[z5monthly].close>ratesDaily[z5monthly].open)
                    {
                     downshadowz5monthly=MathAbs((ratesDaily[z5monthly].low-ratesDaily[z5monthly].open+(1*_Point))/_Point);
                    }
                  if(ratesDaily[z5monthly].close<ratesDaily[z5monthly].open)
                    {
                     downshadowz5monthly=MathAbs((ratesDaily[z5monthly].low-ratesDaily[z5monthly].close+(1*_Point))/_Point);
                    }

                  Bodyz5monthly=MathAbs(ratesDaily[z5monthly].close-ratesDaily[z5monthly].open)/_Point;
                  int nLL25monthly=z5monthly;
                  int MaxNLL25monthly=z5monthly;
                  double MaxBodyLL25monthly=z5monthly;
                  while(nLL25monthly<(nOfCandleWmonthly+z5monthly)&& nLL25monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double BodyLL25monthly=((ratesDaily[nLL25monthly].open-ratesDaily[nLL25monthly].close)/_Point);
                     double dyLL25monthly=MathAbs(BodyLL25monthly);
                     if(dyLL25monthly>MaxBodyLL25monthly)
                       {
                        MaxBodyLL25monthly=dyLL25monthly;
                        MaxNLL25monthly=nLL25monthly;
                       }
                     nLL25monthly++;
                    }

                  int n2LL25monthly=z5monthly;
                  int MaxN2LL25monthly=z5monthly;
                  double MaxBody2LL25monthly=z5monthly;
                  while(n2LL25monthly<(nOfCandleWmonthly+z5monthly)&& n2LL25monthly<Bars(NULL,PERIOD_MN1)-q-1)
                    {
                     double Body2LL25monthly=((ratesDaily[n2LL25monthly].open-ratesDaily[n2LL25monthly].close)/_Point);
                     double dy2LL25monthly=MathAbs(Body2LL25monthly);
                     if(dy2LL25monthly<MaxBodyLL25monthly && dy2LL25monthly>MaxBody2LL25monthly)
                       {
                        MaxBody2LL25monthly=dy2LL25monthly;
                        MaxN2LL25monthly=n2LL25monthly;
                       }
                     n2LL25monthly++;
                    }

                  double darsadLL25monthly=(Bodyz5monthly/((MaxBodyLL25monthly+MaxBody2LL25monthly)/2))*100;

                  double candlesizeLL25monthly;
                  if(darsadLL25monthly>=59)
                     candlesizeLL25monthly=4;
                  if(darsadLL25monthly<59 && darsadLL25monthly>=39)
                     candlesizeLL25monthly=3;
                  if(darsadLL25monthly<39 && darsadLL25monthly>5)
                     candlesizeLL25monthly=2;
                  if(darsadLL25monthly<=5)
                     candlesizeLL25monthly=1;

                  if(ratesDaily[z5monthly].close>LLmonthly && candlesizeLL25monthly>=3 && downshadowz5monthly>=Bodyz5monthly && ratesDaily[z5monthly].low<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=ratesDaily[z5monthly].low;
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LH41-"+z5monthly,OBJ_VLINE,0,ratesDaily[z5monthly].time,ratesDaily[z5monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z5monthly].close>LLmonthly && candlesizeLL25monthly<3 && downshadowz5monthly>=(2*Bodyz5monthly) && ratesDaily[z5monthly].low<(LLmonthly-(MinLimitmonthly)))
                    {
                     LL2monthly=ratesDaily[z5monthly].low;
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LH42-"+z5monthly,OBJ_VLINE,0,ratesDaily[z5monthly].time,ratesDaily[z5monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z5monthly].close>LLmonthly && candlesizeLL25monthly>=3 && ratesDaily[z5monthly].low<(LLmonthly-(MinLimitmonthly)) && (ratesDaily[z5monthly].close>ratesDaily[z5monthly].open))
                    {
                     LL2monthly=ratesDaily[z5monthly].low;
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LH43-"+z5monthly,OBJ_VLINE,0,ratesDaily[z5monthly].time,ratesDaily[z5monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5monthly,OBJPROP_SELECTABLE,true);
                    }

                  if(z5monthly>shoroL2monthly && ratesDaily[z5monthly].close<LLmonthly && candlesizeLL25monthly>=3 && ratesDaily[z5monthly].low<(LLmonthly-(MinLimitmonthly)) && ratesDaily[z5monthly-1].high>(ratesDaily[z5monthly].close+(0.45*(ratesDaily[z5monthly].open-ratesDaily[z5monthly].close))))
                    {
                     LL2monthly=MathMin(ratesDaily[z5monthly].low,ratesDaily[z5monthly-1].low);
                     if(LL2monthly>minLL2monthly)minLL2monthly=LL2monthly;
                     ObjectCreate(0,"ML LL2 Candid LH44-"+z5monthly,OBJ_VLINE,0,ratesDaily[z5monthly].time,ratesDaily[z5monthly].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5monthly,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5monthly,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5monthly,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5monthly,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5monthly,OBJPROP_SELECTABLE,true);
                    }

                 }
              }
            z5monthly++;
           }

        }

      int cntTmonthly,cntLmonthly;
      if(minTL2monthly==TLmonthly+((TLmonthly-LLmonthly)*2) && cntTmonthly==0)
        {
         Alert(Symbol(),"حد دوم بالا یافت نشد");
         cntTmonthly=1;
        }
      if(minLL2monthly==LLmonthly-((TLmonthly-LLmonthly)*2) && cntLmonthly==0)
        {
         Alert(Symbol(),"حد دوم پایین یافت نشد");
         cntLmonthly=1;
        }

      int z_starmonthly=q+1;
      int nz_starmonthly=q+1;
      double minTL2_starmonthly=TLmonthly+(600*_Point);
      double TL2_starmonthly;

      while(z_starmonthly<Bars(NULL,PERIOD_MN1)-1)
        {
         if(ratesMonthly[z_starmonthly].high>(TLmonthly+(250*_Point)) && ratesMonthly[z_starmonthly].close<TLmonthly && ratesMonthly[z_starmonthly].open>LLmonthly && ratesMonthly[z_starmonthly].open<TLmonthly)
           {
            TL2_starmonthly=ratesMonthly[z_starmonthly].high;
            if(TL2_starmonthly<minTL2_starmonthly)minTL2_starmonthly=TL2_starmonthly;
           }
         z_starmonthly++;
        }

      int y_starmonthly=q+1;
      int ny_starmonthly=q+1;
      double minLL2_starmonthly=LLmonthly-(600*_Point);
      double LL2_starmonthly;
      while(y_starmonthly<Bars(NULL,PERIOD_MN1)-1)
        {
         if(ratesMonthly[y_starmonthly].low<(LLmonthly-(250*_Point)) && ratesMonthly[y_starmonthly].close>LLmonthly && LLmonthly<ratesMonthly[y_starmonthly].open && ratesMonthly[y_starmonthly].open<TLmonthly)
           {
            LL2_starmonthly=ratesMonthly[y_starmonthly].low;
            if(LL2_starmonthly>minLL2_starmonthly)minLL2_starmonthly=LL2_starmonthly;
           }
         y_starmonthly++;
        }

      ObjectCreate  (0,"ML Start-"+q, OBJ_VLINE, 0,ratesMonthly[q].time+60*60*24*30,0);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger (0,"ML Start-"+q, OBJPROP_TIMEFRAMES, OBJ_PERIOD_D1);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_COLOR,Black);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML Start-"+q,OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML Start-"+q,OBJPROP_SELECTABLE,true);


      ObjectCreate  (0,"ML End-"+q, OBJ_VLINE, 0,ratesMonthly[q].time+60*60*24*64,0);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_TIMEFRAMES, OBJ_PERIOD_D1);
      ObjectSetInteger (0,"ML End-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger (0,"ML End-"+q,OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_SELECTABLE,true);
      
      
      ObjectCreate(0,"ML starlineT",OBJ_HLINE,0,0,minTL2_starmonthly,0,0);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_WIDTH,0);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML starlineL",OBJ_HLINE,0,0,minLL2_starmonthly,0,0);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_WIDTH,0);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML TL",OBJ_HLINE,0,0,TLmonthly,0,0);
      ObjectSetInteger(0,"ML TL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML TL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML TL2",OBJ_HLINE,0,0,minTL2monthly,0,0);
      ObjectSetInteger(0,"ML TL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML TL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL2",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML LL",OBJ_HLINE,0,0,LLmonthly,0,0);
      ObjectSetInteger(0,"ML LL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML LL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML LL2",OBJ_HLINE,0,0,minLL2monthly,0,0);
      ObjectSetInteger(0,"ML LL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML LL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL2",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML TL",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"ML TL",OBJPROP_WIDTH,2);
      ObjectSetInteger(0,"ML TL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML LL",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"ML LL",OBJPROP_WIDTH,2);
      ObjectSetInteger(0,"ML LL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML TL2",OBJPROP_COLOR,Purple);
      ObjectSetInteger(0,"ML TL2",OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML TL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL2",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML LL2",OBJPROP_COLOR,Purple);
      ObjectSetInteger(0,"ML LL2",OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML LL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL2",OBJPROP_SELECTABLE,true);

      Firstinlinemonthly=LLmonthly+((TLmonthly-LLmonthly)/3);
      Secondinlinemonthly=LLmonthly+(2*(TLmonthly-LLmonthly)/3);

      ObjectCreate(0,"ML First 0.33",OBJ_HLINE,0,0,Firstinlinemonthly,0,0);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML Second 0.33",OBJ_HLINE,0,0,Secondinlinemonthly,0,0);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_MN1|OBJ_PERIOD_W1|OBJ_PERIOD_H4|OBJ_PERIOD_D1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_SELECTABLE,true);
      ChartRedraw(0);

      int dirmonthly=0;
      string directionmonthly;
      int cntdirmonthly=0;
      int pmonthly=q+1;
      for(pmonthly=q+1;pmonthly<=7+q; pmonthly++)

        {
         if(ratesMonthly[pmonthly].open<ratesMonthly[q].low && cntdirmonthly==0)
           {
            directionmonthly="صعودی";
            dirmonthly=2;
            cntdirmonthly=1;
           }
         if(ratesMonthly[pmonthly].open>ratesMonthly[q].high && cntdirmonthly==0)
           {
            directionmonthly="نزولی";
            dirmonthly=0;
            cntdirmonthly=1;
           }
        }

      //-----------Jadval Tahlil 1   
      string tahlilAmonthly;
      string tahlilBmonthly;

      if(dirmonthly>1 && bigmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي،شکست حد بال";
      if(dirmonthly>1 && bigmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirmonthly>1 && mediummonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly>1 && mediummonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly>1 && smallmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirmonthly>1 && smallmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly>1 && spinningmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirmonthly>1 && spinningmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";

      if(dirmonthly<1 && bigmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly<1 && bigmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly<1 && mediummonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly<1 && mediummonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly<1 && smallmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirmonthly<1 && smallmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";
      if(dirmonthly<1 && spinningmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilAmonthly="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirmonthly<1 && spinningmonthly>=1 && candletypemonthly=="تقاضا")
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";

      if(dirmonthly>1 && bigmonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirmonthly>1 && bigmonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly>1 && mediummonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين ";
      if(dirmonthly>1 && mediummonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا ";
      if(dirmonthly>1 && smallmonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly>1 && smallmonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirmonthly>1 && spinningmonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly>1 && spinningmonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";

      if(dirmonthly<1 && bigmonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirmonthly<1 && bigmonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly<1 && mediummonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirmonthly<1 && mediummonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirmonthly<1 && smallmonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirmonthly<1 && smallmonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirmonthly<1 && spinningmonthly>=1 && candletypemonthly=="عرضه")
         tahlilAmonthly="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirmonthly<1 && spinningmonthly>=1 && candletypemonthly=="عرضه")
         tahlilBmonthly="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";

      ObjectCreate(0,"ML direction_M",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML direction_M",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML direction_M",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML direction_M",OBJPROP_YDISTANCE,20);
      ObjectSetString(0,"ML direction_M",OBJPROP_TEXT,directionmonthly);
      ObjectSetInteger(0,"ML direction_M",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML direction_M",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML direction_M",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML candletype_M",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML candletype_M",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML candletype_M",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML candletype_M",OBJPROP_YDISTANCE,35);
      ObjectSetString(0,"ML candletype_M",OBJPROP_TEXT,candletypemonthly);
      ObjectSetInteger(0,"ML candletype_M",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML candletype_M",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML candletype_M",OBJPROP_SELECTABLE,true);


      ObjectCreate(0,"ML X_M",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML X_M",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML X_M",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML X_M",OBJPROP_YDISTANCE,50);
      ObjectSetString(0,"ML X_M",OBJPROP_TEXT,Xmonthly);
      ObjectSetInteger(0,"ML X_M",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML X_M",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML X_M",OBJPROP_SELECTABLE,true);

      Comment("   جهت اوليه","   ",directionmonthly,"\n","   نوع کندل","   ",candletypemonthly,"\n","   ","\n  اندازه بدنه کندل مورد ارزيابي:","   ",(badanehmonthly),"\n","  اندازه سايه بالا","     ",upshadowmonthly,"\n","  اندازه سايه پايين","    ",downshadowmonthly,"\n","\n ميانگين دو بزرگترين کندل محيط","   ",(MaxBodymonthly+MaxBody2monthly)/2,"\n   شماره بزرگترين کندل محيط:","   ",MaxNmonthly,"\n   شماره دومين کندل بزرگ محيط:","   ",MaxN2monthly,"\n  نسبت بدنه کندل مورد ارزيابي به بدنه مبنا:","   ",Totaldarsadmonthly,"\n","  نوع کندل","   ",Xmonthly,"\n","\n","   حد احتياط بالا","   ",TLmonthly,"\n","   حد احتياط پايين","   ",LLmonthly,"\n","\n",tahlilAmonthly,"\n",tahlilBmonthly);
      //--- create timer
      EventSetTimer(4*7200);
     }

   if(typeofanalysis==1)
     {
      if(nOfCandleWdaily>Bars(NULL,PERIOD_D1))
        {
         Alert("تعداد کندل اشتباه است");
         return(-1);
        }



      double badanehdaily=MathAbs((ratesDaily[q].open-ratesDaily[q].close)/_Point);

      if((ratesDaily[q].open-ratesDaily[q].close)>0)
         candletypedaily="عرضه";
      if((ratesDaily[q].close-ratesDaily[q].open)>0)
         candletypedaily="تقاضا";

      bool upshadowlenghtdaily=0;
      bool downshadowlenghtdaily=0;
      double upshadowdaily=0;
      double downshadowdaily=0;

      int ndaily=q;
      int MaxNdaily=q;
      double MaxBodydaily=q;
      while(ndaily<(nOfCandleWdaily+q))
        {
         double Bodydaily=((ratesDaily[ndaily].open-ratesDaily[ndaily].close)/_Point);
         double dydaily=MathAbs(Bodydaily);
         if(dydaily>MaxBodydaily)
           {
            MaxBodydaily=dydaily;
            MaxNdaily=ndaily;
           }
         ndaily++;
        }

      int n2daily=q;
      int MaxN2daily=q;
      double MaxBody2daily=q;
      while(n2daily<(nOfCandleWdaily+q))
        {
         double Body2daily=((ratesDaily[n2daily].open-ratesDaily[n2daily].close)/_Point);
         double dy2daily=MathAbs(Body2daily);
         if(dy2daily<MaxBodydaily && dy2daily>MaxBody2daily)
           {
            MaxBody2daily=dy2daily;
            MaxN2daily=n2daily;
           }
         n2daily++;
        }

      double darsaddaily=(badanehdaily/((MaxBodydaily+MaxBody2daily)/2))*100;
      double Totaldarsaddaily=darsaddaily;

      bool bigdaily=0;
      bool mediumdaily=0;
      bool smalldaily=0;
      bool spinningdaily=0;
      string Xdaily;

      if(Totaldarsaddaily>=59)
         Xdaily="بزرگ";
      if(Totaldarsaddaily<59 && Totaldarsaddaily>=39)
         Xdaily="متوسط";
      if(Totaldarsaddaily<39 && Totaldarsaddaily>5)
         Xdaily="کوچک";
      if(Totaldarsaddaily<=5)
         Xdaily="اسپينينگ";
      if(Totaldarsaddaily>=59)
        {
         bigdaily=1;
         candlesizedaily=4;
        }
      if(Totaldarsaddaily<59 && Totaldarsaddaily>=39)
        {
         mediumdaily=1;
         candlesizedaily=3;
        }
      if(Totaldarsaddaily<39 && Totaldarsaddaily>5)
        {
         smalldaily=1;
         candlesizedaily=2;
        }
      if(Totaldarsaddaily<=5)
        {
         spinningdaily=1;
         candlesizedaily=1;
        }

      if(ratesDaily[q].close>ratesDaily[q].open)
        {
         upshadowdaily=MathAbs((ratesDaily[q].high-ratesDaily[q].close+(1*_Point))/_Point);
         downshadowdaily=MathAbs((ratesDaily[q].open-ratesDaily[q].low+(1*_Point))/_Point);
        }
      if(ratesDaily[q].close<ratesDaily[q].open)
        {
         upshadowdaily=MathAbs((ratesDaily[q].high-ratesDaily[q].open+(1 *_Point))/_Point);
         downshadowdaily=MathAbs((ratesDaily[q].close-ratesDaily[q].low+(1 *_Point))/_Point);
        }

      if(upshadowdaily>0.003 && upshadowdaily>(1.5*(badanehdaily)) && candlesizedaily<3)
         upshadowlenghtdaily=1;
      if(upshadowdaily>0.003 && upshadowdaily>(1*(badanehdaily)) && candlesizedaily>=3)
         upshadowlenghtdaily=1;

      if(downshadowdaily>0.003 && downshadowdaily>(1.5*(badanehdaily)) && candlesizedaily<3)
         downshadowlenghtdaily=1;
      if(downshadowdaily>0.003 && downshadowdaily>(1*(badanehdaily)) && candlesizedaily>=3)
         downshadowlenghtdaily=1;

      if(upshadowlenghtdaily==1 && downshadowlenghtdaily==1 && 0.9<(upshadowdaily/downshadowdaily) && (upshadowdaily/downshadowdaily)<1.1)
        {
         Comment(upshadowdaily/downshadowdaily);
         Alert("This Month is doubtfull , its better to wait for next Month on this symbol");
         return(-1);
        }

      if(bigdaily>=1 && ratesDaily[q].close>ratesDaily[q].open)
         TLdaily=ratesDaily[q].high;
      if(bigdaily>=1 && ratesDaily[q].close>ratesDaily[q].open)
         LLdaily=(ratesDaily[q].open+(0.75*(badanehdaily*_Point)));

      if(upshadowlenghtdaily==1 && bigdaily>=1 && ratesDaily[q].close>ratesDaily[q].open)
         TLdaily=ratesDaily[q].high-(0.5*(upshadowdaily*_Point));

      if(bigdaily>=1 && ratesDaily[q].close<ratesDaily[q].open)
         LLdaily=ratesDaily[q].low;
      if(bigdaily>=1 && ratesDaily[q].close<ratesDaily[q].open)
         TLdaily=(ratesDaily[q].close+(0.25*(badanehdaily*_Point)));
      if(downshadowlenghtdaily==1 && bigdaily>=1 && ratesDaily[q].close<ratesDaily[q].open)
         LLdaily=ratesDaily[q].low+(0.5*(downshadowdaily*_Point));

      if(mediumdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         LLdaily=ratesDaily[q].low;
      if(mediumdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         TLdaily=(ratesDaily[q].close+(0.5*(badanehdaily*_Point)));

      if(downshadowlenghtdaily==1 && mediumdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         LLdaily=ratesDaily[q].low+(0.5*(downshadowdaily*_Point));

      if(mediumdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         TLdaily=ratesDaily[q].high;
      if(mediumdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         LLdaily=(ratesDaily[q].open+(0.5*(badanehdaily*_Point)));

      if(upshadowlenghtdaily==1 && mediumdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         TLdaily=ratesDaily[q].high -(0.5*(upshadowdaily*_Point));

      if(smalldaily==1 && ratesDaily[q].close>ratesDaily[q].open && spinningdaily==0)
         TLdaily=ratesDaily[q].high;
      if(smalldaily==1 && ratesDaily[q].close>ratesDaily[q].open && spinningdaily==0)
         LLdaily=ratesDaily[q].low;

      if(upshadowlenghtdaily==1 && smalldaily==1 && ratesDaily[q].close>ratesDaily[q].open && spinningdaily==0)
         TLdaily=ratesDaily[q].high -(0.5*(upshadowdaily*_Point));
      if(downshadowlenghtdaily==1 && smalldaily==1 && ratesDaily[q].close>ratesDaily[q].open && spinningdaily==0)
         LLdaily=ratesDaily[q].low+(0.5*(downshadowdaily*_Point));

      if(smalldaily==1 && ratesDaily[q].close<ratesDaily[q].open && spinningdaily==0)
         LLdaily=ratesDaily[q].low;
      if(smalldaily==1 && ratesDaily[q].close<ratesDaily[q].open && spinningdaily==0)
         TLdaily=ratesDaily[q].high;

      if(downshadowlenghtdaily==1 && smalldaily==1 && ratesDaily[q].close<ratesDaily[q].open && spinningdaily==0)
         LLdaily=ratesDaily[q].close-(0.5*(downshadowdaily*_Point));
      if(upshadowlenghtdaily==1 && smalldaily==1 && ratesDaily[q].close<ratesDaily[q].open && spinningdaily==0)
         TLdaily=ratesDaily[q].open+(0.5*(upshadowdaily*_Point));

      if(spinningdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         TLdaily=ratesDaily[q].high;
      if(spinningdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         LLdaily=ratesDaily[q].low;

      if(spinningdaily==1 && upshadowlenghtdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         TLdaily=ratesDaily[q].high -(0.5*(upshadowdaily*_Point));
      if(spinningdaily==1 && downshadowlenghtdaily==1 && ratesDaily[q].close>ratesDaily[q].open)
         LLdaily=ratesDaily[q].low+(0.5*(downshadowdaily*_Point));

      if(spinningdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         LLdaily=ratesDaily[q].low;
      if(spinningdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         TLdaily=ratesDaily[q].high;

      if(spinningdaily==1 && downshadowlenghtdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         LLdaily=ratesDaily[q].close-(0.5*(downshadowdaily*_Point));
      if(spinningdaily==1 && upshadowlenghtdaily==1 && ratesDaily[q].close<ratesDaily[q].open)
         TLdaily=ratesDaily[q].open+(0.5*(upshadowdaily*_Point));

      double MinLimitdaily=TLdaily;
      if(candlesizedaily==4) MinLimitdaily=MinRateBdaily*(((NormalizeDouble(TLdaily,_Digits)-NormalizeDouble(LLdaily,_Digits)))/6);
      if(candlesizedaily==3) MinLimitdaily=MinRateMdaily*(((NormalizeDouble(TLdaily,_Digits)-NormalizeDouble(LLdaily,_Digits)))/6);
      if(candlesizedaily==2) MinLimitdaily=MinRateSdaily*(((NormalizeDouble(TLdaily,_Digits)-NormalizeDouble(LLdaily,_Digits)))/6);
      if(candlesizedaily==1) MinLimitdaily=MinRateSPdaily*(((NormalizeDouble(TLdaily,_Digits)-NormalizeDouble(LLdaily,_Digits)))/6);

      double safetylimitUdaily=MathMax((TLdaily+(MinLimit2daily*_Point)),(TLdaily+MinLimitdaily));
      double safetylimitDdaily=MathMin((LLdaily-(MinLimit2daily*_Point)),(LLdaily-MinLimitdaily));

      int zdaily=q;
      int nzdaily=q;
      minTL2daily=TLdaily+((TLdaily-LLdaily)*2);
      minLL2daily=LLdaily-((TLdaily-LLdaily)*2);
      int countdaily=0;
      bool mohitidaily;
      double Bodyzdaily;
      double upshadowzdaily;
      double downshadowzdaily;

      while(zdaily<(Bars(NULL,PERIOD_D1)-1) && countdaily<=MaxTPSLCalcdaily && countdaily<=Bars(NULL,PERIOD_D1)-2-zdaily)
        {
           {
            if(ratesDaily[zdaily].high>LLdaily && ratesDaily[zdaily].low<TLdaily)
              {
               mohitidaily=1;
               countdaily++;
               ObjectCreate(0,"ML MohitiTW-"+zdaily,OBJ_ARROW_UP,0,ratesDaily[zdaily].time,ratesDaily[zdaily].low);
               ObjectSetInteger(0,"ML MohitiTW-"+zdaily,OBJPROP_COLOR,Purple);
               ObjectSetInteger(0,"ML MohitiTW-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
               ObjectSetInteger(0,"ML MohitiTW-"+zdaily,OBJPROP_HIDDEN,false);
               ObjectSetInteger(0,"ML MohitiTW-"+zdaily,OBJPROP_SELECTABLE,true);
               ChartRedraw(0);
              }
            else mohitidaily=0;
           }

         if(mohitidaily==1)
           {
            if((ratesDaily[zdaily].high>TLdaily && ratesDaily[zdaily].open<TLdaily))
              {

               if(ratesDaily[zdaily].close>ratesDaily[zdaily].open)
                 {
                  upshadowzdaily=MathAbs((ratesDaily[zdaily].high-ratesDaily[zdaily].close+(1*_Point))/_Point);
                 }
               if(ratesDaily[zdaily].close<ratesDaily[zdaily].open)
                 {
                  upshadowzdaily=MathAbs((ratesDaily[zdaily].high-ratesDaily[zdaily].open+(1*_Point))/_Point);
                 }

               Bodyzdaily=MathAbs(ratesDaily[zdaily].close-ratesDaily[zdaily].open)/_Point;
               int nTL2daily=zdaily;
               int MaxNTL2daily=zdaily;
               double MaxBodyTL2daily=zdaily;
               while(nTL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double BodyTL2daily=((ratesDaily[nTL2daily].open-ratesDaily[nTL2daily].close)/_Point);
                  double dyTL2daily=MathAbs(BodyTL2daily);
                  if(dyTL2daily>MaxBodyTL2daily)
                    {
                     MaxBodyTL2daily=dyTL2daily;
                     MaxNTL2daily=nTL2daily;
                    }
                  nTL2daily++;
                 }

               int n2TL2daily=zdaily;
               int MaxN2TL2daily=zdaily;
               double MaxBody2TL2daily=zdaily;
               while(n2TL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double Body2TL2daily=((ratesDaily[n2TL2daily].open-ratesDaily[n2TL2daily].close)/_Point);
                  double dy2TL2daily=MathAbs(Body2TL2daily);
                  if(dy2TL2daily<MaxBodyTL2daily && dy2TL2daily>MaxBody2TL2daily)
                    {
                     MaxBody2TL2daily=dy2TL2daily;
                     MaxN2TL2daily=n2TL2daily;
                    }
                  n2TL2daily++;
                 }

               double darsadTL2daily=(Bodyzdaily/((MaxBodyTL2daily+MaxBody2TL2daily)/2))*100;

               double candlesizeTL2daily;
               if(darsadTL2daily>=59)
                  candlesizeTL2daily=4;
               if(darsadTL2daily<59 && darsadTL2daily>=39)
                  candlesizeTL2daily=3;
               if(darsadTL2daily<39 && darsadTL2daily>5)
                  candlesizeTL2daily=2;
               if(darsadTL2daily<=5)
                  candlesizeTL2daily=1;

               if(ratesDaily[zdaily].close<TLdaily && candlesizeTL2daily>=3 && upshadowzdaily>=Bodyzdaily && ratesDaily[zdaily].high>(TLdaily+(MinLimitdaily)))
                 {
                  TL2daily=ratesDaily[zdaily].high;
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate(0,"ML TL2 Candid W1-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W1-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesDaily[zdaily].close<TLdaily && candlesizeTL2daily<3 && upshadowzdaily>=(2*Bodyzdaily) && ratesDaily[zdaily].high>(TLdaily+(MinLimitdaily)))
                 {
                  TL2daily=ratesDaily[zdaily].high;
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate(0,"ML TL2 Candid W2-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W2-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesDaily[zdaily].close<TLdaily && candlesizeTL2daily>=3 && ratesDaily[zdaily].high>(TLdaily+(MinLimitdaily)) && (ratesDaily[zdaily].close<ratesDaily[zdaily].open))
                 {
                  TL2daily=ratesDaily[zdaily].high;
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate(0,"ML TL2 Candid W3-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W3-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(zdaily>q && ratesDaily[zdaily].close>TLdaily && candlesizeTL2daily>=3 && ratesDaily[zdaily].high>(TLdaily+(MinLimitdaily)) && ratesDaily[zdaily-1].low<(ratesDaily[zdaily].close-(0.45*(ratesDaily[zdaily].close-ratesDaily[zdaily].open))))
                 {
                  TL2daily=MathMax(ratesDaily[zdaily].high,ratesDaily[zdaily-1].high);
                  if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                  ObjectCreate(0,"ML TL2 Candid W4-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zdaily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML TL2 Candid W4-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

              }

            if(((ratesDaily[zdaily].low<LLdaily && ratesDaily[zdaily].open>LLdaily)))
              {

               if(ratesDaily[zdaily].close>ratesDaily[zdaily].open)
                 {
                  downshadowzdaily=MathAbs((ratesDaily[zdaily].low-ratesDaily[zdaily].open+(1*_Point))/_Point);
                 }
               if(ratesDaily[zdaily].close<ratesDaily[zdaily].open)
                 {
                  downshadowzdaily=MathAbs((ratesDaily[zdaily].low-ratesDaily[zdaily].close+(1*_Point))/_Point);
                 }

               Bodyzdaily=MathAbs(ratesDaily[zdaily].close-ratesDaily[zdaily].open)/_Point;
               int nLL2daily=zdaily;
               int MaxNLL2daily=zdaily;
               double MaxBodyLL2daily=zdaily;
               while(nLL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double BodyLL2daily=((ratesDaily[nLL2daily].open-ratesDaily[nLL2daily].close)/_Point);
                  double dyLL2daily=MathAbs(BodyLL2daily);
                  if(dyLL2daily>MaxBodyLL2daily)
                    {
                     MaxBodyLL2daily=dyLL2daily;
                     MaxNLL2daily=nLL2daily;
                    }
                  nLL2daily++;
                 }

               int n2LL2daily=zdaily;
               int MaxN2LL2daily=zdaily;
               double MaxBody2LL2daily=zdaily;
               while(n2LL2daily<(nOfCandleWdaily+zdaily))
                 {
                  double Body2LL2daily=((ratesDaily[n2LL2daily].open-ratesDaily[n2LL2daily].close)/_Point);
                  double dy2LL2daily=MathAbs(Body2LL2daily);
                  if(dy2LL2daily<MaxBodyLL2daily && dy2LL2daily>MaxBody2LL2daily)
                    {
                     MaxBody2LL2daily=dy2LL2daily;
                     MaxN2LL2daily=n2LL2daily;
                    }
                  n2LL2daily++;
                 }

               double darsadLL2daily=(Bodyzdaily/((MaxBodyLL2daily+MaxBody2LL2daily)/2))*100;

               double candlesizeLL2daily;
               if(darsadLL2daily>=59)
                  candlesizeLL2daily=4;
               if(darsadLL2daily<59 && darsadLL2daily>=39)
                  candlesizeLL2daily=3;
               if(darsadLL2daily<39 && darsadLL2daily>5)
                  candlesizeLL2daily=2;
               if(darsadLL2daily<=5)
                  candlesizeLL2daily=1;

               if(ratesDaily[zdaily].close>LLdaily && candlesizeLL2daily>=3 && downshadowzdaily>=Bodyzdaily && ratesDaily[zdaily].low<(LLdaily-(MinLimitdaily)))
                 {
                  LL2daily=ratesDaily[zdaily].low;
                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate(0,"ML LL2 Candid W1-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W1-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesDaily[zdaily].close>LLdaily && candlesizeLL2daily<3 && downshadowzdaily>=(2*Bodyzdaily) && ratesDaily[zdaily].low<(LLdaily-(MinLimitdaily)))
                 {
                  LL2daily=ratesDaily[zdaily].low;
                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate(0,"ML LL2 Candid W2-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W2-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(ratesDaily[zdaily].close>LLdaily && candlesizeLL2daily>=3 && ratesDaily[zdaily].low<(LLdaily-(MinLimitdaily)) && (ratesDaily[zdaily].close>ratesDaily[zdaily].open))
                 {
                  LL2daily=ratesDaily[zdaily].low;
                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate(0,"ML LL2 Candid W3-"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W3-"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

               if(zdaily>q && ratesDaily[zdaily].close<LLdaily && candlesizeLL2daily>=3 && ratesDaily[zdaily].low<(LLdaily-(MinLimitdaily)) && ratesDaily[zdaily-1].high>(ratesDaily[zdaily].close+(0.45*(ratesDaily[zdaily].open-ratesDaily[zdaily].close))))
                 {
                  LL2daily=MathMin(ratesDaily[zdaily].low,ratesDaily[zdaily-1].low);
                  if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                  ObjectCreate(0,"ML LL2 Candid W4"+zdaily,OBJ_VLINE,0,ratesDaily[zdaily].time,ratesDaily[zdaily].open);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zdaily,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zdaily,OBJPROP_COLOR,Red);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zdaily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML LL2 Candid W4"+zdaily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }

              }
           }
         zdaily++;
         ChartRedraw(0);
        }

      if(minTL2daily==TLdaily+((TLdaily-LLdaily)*2))
        {
         int shoroTdaily=iBarShift(NULL,PERIOD_H4,ratesDaily[q].time);
         ObjectCreate(0,"ML ShoroTD1-"+shoroTdaily,OBJ_VLINE,0,ratesWeekly[shoroTdaily-1].time,0);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTdaily,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTdaily,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML ShoroTD1-"+shoroTdaily,OBJPROP_SELECTABLE,true);
         ChartRedraw(0);

         int z2daily=shoroTdaily;
         int nz2daily=shoroTdaily;
         int count2daily=0;
         bool mohiti2daily;
         double Bodyz2daily;
         double upshadowz2daily;


         while(z2daily<(Bars(NULL,PERIOD_H4)-2) && count2daily<=MaxTPSLCalcdaily && count2daily<=Bars(NULL,PERIOD_H4)-2-z2daily)
           {
              {
               if(ratesWeekly[z2daily].high>LLdaily && ratesWeekly[z2daily].low<TLdaily)
                 {
                  mohiti2daily=1;
                  count2daily++;
                  ObjectCreate(0,"ML MohitiTD1T-"+z2daily,OBJ_ARROW_UP,0,ratesWeekly[z2daily].time,ratesWeekly[z2daily].low);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2daily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2daily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTD1T-"+z2daily,OBJPROP_SELECTABLE,true);
                  ChartRedraw(0);
                 }
               else mohiti2daily=0;
              }

            if(mohiti2daily==1)
              {
               if((ratesWeekly[z2daily].high>TLdaily && ratesWeekly[z2daily].open<TLdaily))
                 {
                  if(ratesWeekly[z2daily].close>ratesWeekly[z2daily].open)
                    {
                     upshadowz2daily=MathAbs((ratesWeekly[z2daily].high-ratesWeekly[z2daily].close+(1*_Point))/_Point);
                    }
                  if(ratesWeekly[z2daily].close<ratesWeekly[z2daily].open)
                    {
                     upshadowz2daily=MathAbs((ratesWeekly[z2daily].high-ratesWeekly[z2daily].open+(1*_Point))/_Point);
                    }

                  Bodyz2daily=MathAbs(ratesWeekly[z2daily].close-ratesWeekly[z2daily].open)/_Point;
                  int nTL22daily=z2daily;
                  int MaxNTL22daily=z2daily;
                  double MaxBodyTL22daily=z2daily;
                  while(nTL22daily<(nOfCandleWdaily+z2daily))
                    {
                     double BodyTL22daily=((ratesWeekly[nTL22daily].open-ratesWeekly[nTL22daily].close)/_Point);
                     double dyTL22daily=MathAbs(BodyTL22daily);
                     if(dyTL22daily>MaxBodyTL22daily)
                       {
                        MaxBodyTL22daily=dyTL22daily;
                        MaxNTL22daily=nTL22daily;
                       }
                     nTL22daily++;
                    }

                  int n2TL22daily=z2daily;
                  int MaxN2TL22daily=z2daily;
                  double MaxBody2TL22daily=z2daily;
                  while(n2TL22daily<(nOfCandleWdaily+z2daily))
                    {
                     double Body2TL22daily=((ratesWeekly[n2TL22daily].open-ratesWeekly[n2TL22daily].close)/_Point);
                     double dy2TL22daily=MathAbs(Body2TL22daily);
                     if(dy2TL22daily<MaxBodyTL22daily && dy2TL22daily>MaxBody2TL22daily)
                       {
                        MaxBody2TL22daily=dy2TL22daily;
                        MaxN2TL22daily=n2TL22daily;
                       }
                     n2TL22daily++;
                    }

                  double darsadTL22daily=(Bodyz2daily/((MaxBodyTL22daily+MaxBody2TL22daily)/2))*100;

                  double candlesizeTL22daily;
                  if(darsadTL22daily>=59)
                     candlesizeTL22daily=4;
                  if(darsadTL22daily<59 && darsadTL22daily>=39)
                     candlesizeTL22daily=3;
                  if(darsadTL22daily<39 && darsadTL22daily>5)
                     candlesizeTL22daily=2;
                  if(darsadTL22daily<=5)
                     candlesizeTL22daily=1;

                  if(ratesWeekly[z2daily].close<TLdaily && candlesizeTL22daily>=3 && upshadowz2daily>=Bodyz2daily && ratesWeekly[z2daily].high>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=ratesWeekly[z2daily].high;
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid D11-"+z2daily,OBJ_VLINE,0,ratesWeekly[z2daily].time,ratesWeekly[z2daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D11-"+z2daily,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(ratesWeekly[z2daily].close<TLdaily && candlesizeTL22daily<3 && upshadowz2daily>=(2*Bodyz2daily) && ratesWeekly[z2daily].high>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=ratesWeekly[z2daily].high;
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid D12-"+z2daily,OBJ_VLINE,0,ratesWeekly[z2daily].time,ratesWeekly[z2daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D12-"+z2daily,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(ratesWeekly[z2daily].close<TLdaily && candlesizeTL22daily>=3 && ratesWeekly[z2daily].high>(TLdaily+(MinLimitdaily)) && (ratesWeekly[z2daily].close<ratesWeekly[z2daily].open))
                    {
                     TL2daily=ratesWeekly[z2daily].high;
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid D13-"+z2daily,OBJ_VLINE,0,ratesWeekly[z2daily].time,ratesWeekly[z2daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D13-"+z2daily,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                  if(z2daily>shoroTdaily && ratesWeekly[z2daily].close>TLdaily && candlesizeTL22daily>=3 && ratesWeekly[z2daily].high>(TLdaily+(MinLimitdaily)) && ratesWeekly[z2daily-1].low<(ratesWeekly[z2daily].close-(0.45*(ratesWeekly[z2daily].close-ratesWeekly[z2daily].open))))
                    {
                     TL2daily=MathMax(ratesWeekly[z2daily].high,ratesWeekly[z2daily-1].high);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid D14-"+z2daily,OBJ_VLINE,0,ratesWeekly[z2daily].time,ratesWeekly[z2daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid D14-"+z2daily,OBJPROP_SELECTABLE,true);
                     ChartRedraw(0);
                    }

                 }

              }
              
            z2daily++;

           }
           
        }

      if(minTL2daily==TLdaily+((TLdaily-LLdaily)*2))
        {
         int shoroT2daily=iBarShift(NULL,PERIOD_H1,ratesDaily[q].time);
         ObjectCreate(0,"ML shoroTH4T-"+shoroT2daily,OBJ_VLINE,0,ratesWeekly[shoroT2daily-1].time,ratesDaily[shoroT2daily-1].low);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2daily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2daily,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2daily,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroTH4T-"+shoroT2daily,OBJPROP_SELECTABLE,true);

         int z4daily=shoroT2daily;
         int nz4daily=shoroT2daily;
         int count4daily=0;
         bool mohiti4daily;
         double Bodyz4daily;
         double upshadowz4daily;

         while(z4daily<(Bars(NULL,PERIOD_H1)-1) && count4daily<=MaxTPSLCalcdaily && count4daily<=Bars(NULL,PERIOD_H1)-2-z4daily)
           {
              {
               if(ratesDaily[z4daily].high>LLdaily && ratesDaily[z4daily].low<TLdaily)
                 {
                  mohiti4daily=1;
                  count4daily++;
                  ObjectCreate(0,"ML MohitiTH4T-"+z4daily,OBJ_ARROW,0,ratesDaily[z4daily].time,ratesDaily[z4daily].low);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4daily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4daily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTH4T-"+z4daily,OBJPROP_SELECTABLE,true);
                 }
               else mohiti4daily=0;
              }

            if(mohiti4daily==1)
              {
               if((ratesDaily[z4daily].high>TLdaily && ratesDaily[z4daily].open<TLdaily))
                 {
                  if(ratesDaily[z4daily].close>ratesDaily[z4daily].open)
                    {
                     upshadowz4daily=MathAbs((ratesDaily[z4daily].high-ratesDaily[z4daily].close+(1*_Point))/_Point);
                    }
                  if(ratesDaily[z4daily].close<ratesDaily[z4daily].open)
                    {
                     upshadowz4daily=MathAbs((ratesDaily[z4daily].high-ratesDaily[z4daily].open+(1*_Point))/_Point);
                    }

                  Bodyz4daily=MathAbs(ratesDaily[z4daily].close-ratesDaily[z4daily].open)/_Point;
                  int nTL24daily=z4daily;
                  int MaxNTL24daily=z4daily;
                  double MaxBodyTL24daily=z4daily;
                  while(nTL24daily<(nOfCandleWdaily+z4daily))
                    {
                     double BodyTL24daily=((ratesDaily[nTL24daily].open-ratesDaily[nTL24daily].close)/_Point);
                     double dyTL24daily=MathAbs(BodyTL24daily);
                     if(dyTL24daily>MaxBodyTL24daily)
                       {
                        MaxBodyTL24daily=dyTL24daily;
                        MaxNTL24daily=nTL24daily;
                       }
                     nTL24daily++;
                    }

                  int n2TL24daily=z4daily;
                  int MaxN2TL24daily=z4daily;
                  double MaxBody2TL24daily=z4daily;
                  while(n2TL24daily<(nOfCandleWdaily+z4daily))
                    {
                     double Body2TL24daily=((ratesDaily[n2TL24daily].open-ratesDaily[nTL24daily].close)/_Point);
                     double dy2TL24daily=MathAbs(Body2TL24daily);
                     if(dy2TL24daily<MaxBodyTL24daily && dy2TL24daily>MaxBody2TL24daily)
                       {
                        MaxBody2TL24daily=dy2TL24daily;
                        MaxN2TL24daily=n2TL24daily;
                       }
                     n2TL24daily++;
                    }

                  double darsadTL24daily=(Bodyz4daily/((MaxBodyTL24daily+MaxBody2TL24daily)/2))*100;

                  double candlesizeTL24daily;
                  if(darsadTL24daily>=61)
                     candlesizeTL24daily=4;
                  if(darsadTL24daily<61 && darsadTL24daily>=41)
                     candlesizeTL24daily=3;
                  if(darsadTL24daily<41 && darsadTL24daily>5)
                     candlesizeTL24daily=2;
                  if(darsadTL24daily<=5)
                     candlesizeTL24daily=1;

                  if(ratesDaily[z4daily].close<TLdaily && candlesizeTL24daily>=3 && upshadowz4daily>=Bodyz4daily && ratesDaily[z4daily].high>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=ratesDaily[z4daily].high;
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid H41-"+z4daily,OBJ_VLINE,0,ratesDaily[z4daily].time,ratesDaily[z4daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H41-"+z4daily,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z4daily].close<TLdaily && candlesizeTL24daily<3 && upshadowz4daily>=(2*Bodyz4daily) && ratesDaily[z4daily].high>(TLdaily+(MinLimitdaily)))
                    {
                     TL2daily=ratesDaily[z4daily].high;
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid H42-"+z4daily,OBJ_VLINE,0,ratesDaily[z4daily].time,ratesDaily[z4daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H42-"+z4daily,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z4daily].close<TLdaily && candlesizeTL24daily>=3 && ratesDaily[z4daily].high>(TLdaily+(MinLimitdaily)) && (ratesDaily[z4daily].close<ratesDaily[z4daily].open))
                    {
                     TL2daily=ratesDaily[z4daily].high;
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid H43-"+z4daily,OBJ_VLINE,0,ratesDaily[z4daily].time,ratesDaily[z4daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H43-"+z4daily,OBJPROP_SELECTABLE,true);
                    }

                  if(z4daily>shoroT2daily && ratesDaily[z4daily].close>TLdaily && candlesizeTL24daily>=3 && ratesDaily[z4daily].high>(TLdaily+(MinLimitdaily)) && ratesDaily[z4daily-1].low<(ratesDaily[z4daily].close-(0.45*(ratesDaily[z4daily].close-ratesDaily[z4daily].open))))
                    {
                     TL2daily=MathMax(ratesDaily[z4daily].high,ratesDaily[z4daily-1].high);
                     if(TL2daily<minTL2daily)minTL2daily=TL2daily;
                     ObjectCreate(0,"ML TL2 Candid H44-"+z4daily,OBJ_VLINE,0,ratesDaily[z4daily].time,ratesDaily[z4daily].open);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4daily,OBJPROP_COLOR,Blue);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML TL2 Candid H44-"+z4daily,OBJPROP_SELECTABLE,true);
                    }

                 }

              }
            z4daily++;
           }
         ChartRedraw(0);

        }

      if(minLL2daily==LLdaily-((TLdaily-LLdaily)*2))
        {
         int shoroLdaily=iBarShift(NULL,PERIOD_H4,ratesDaily[q].time);
         ObjectCreate(0,"ML shoroLD1-"+shoroLdaily,OBJ_VLINE,0,ratesWeekly[shoroLdaily-1].time,ratesWeekly[shoroLdaily-1].time);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLdaily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLdaily,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLdaily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLdaily,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroLD1-"+shoroLdaily,OBJPROP_SELECTABLE,true);

         int z3daily=shoroLdaily;
         int nz3daily=shoroLdaily;
         int count3daily=0;
         bool mohiti3daily;
         double Bodyz3daily;
         double downshadowz3daily;

         while(z3daily<Bars(NULL,PERIOD_H4)-1 && count3daily<=MaxTPSLCalcdaily && count3daily<=Bars(NULL,PERIOD_H4)-2-z3daily)
           {
              {
               if(ratesWeekly[z3daily].high>LLdaily && ratesWeekly[z3daily].low<TLdaily)
                 {
                  mohiti3daily=1;
                  count3daily++;
                  ObjectCreate(0,"ML MohitiTD1L-"+z3daily,OBJ_ARROW,0,ratesWeekly[z3daily].time,ratesWeekly[z3daily].low);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3daily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3daily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTD1L-"+z3daily,OBJPROP_SELECTABLE,true);
                 }
               else mohiti3daily=0;
              }

            if(mohiti3daily==1)
              {

               if(((ratesWeekly[z3daily].low<LLdaily && ratesWeekly[z3daily].open>LLdaily)))
                 {

                  if(ratesWeekly[z3daily].close>ratesWeekly[z3daily].open)
                    {
                     downshadowz3daily=MathAbs((ratesWeekly[z3daily].low-ratesWeekly[z3daily].open+(1*_Point))/_Point);
                    }
                  if(ratesWeekly[z3daily].close<ratesWeekly[z3daily].open)
                    {
                     downshadowz3daily=MathAbs((ratesWeekly[z3daily].low-ratesWeekly[z3daily].close+(1*_Point))/_Point);
                    }

                  Bodyz3daily=MathAbs(ratesWeekly[z3daily].close-ratesWeekly[z3daily].open)/_Point;
                  int nLL23daily=z3daily;
                  int MaxNLL23daily=z3daily;
                  double MaxBodyLL23daily=z3daily;

                  while(nLL23daily<(nOfCandleWdaily+z3daily))
                    {
                     double BodyLL23daily=((ratesWeekly[nLL23daily].open-ratesWeekly[nLL23daily].close)/_Point);
                     double dyLL23daily=MathAbs(BodyLL23daily);
                     if(dyLL23daily>MaxBodyLL23daily)
                       {
                        MaxBodyLL23daily=dyLL23daily;
                        MaxNLL23daily=nLL23daily;
                       }
                     nLL23daily++;
                    }

                  int n2LL23daily=z3daily;
                  int MaxN2LL23daily=z3daily;
                  double MaxBody2LL23daily=z3daily;
                  while(n2LL23daily<(nOfCandleWdaily+z3daily))
                    {
                     double Body2LL23daily=((ratesWeekly[n2LL23daily].open-ratesWeekly[n2LL23daily].close)/_Point);
                     double dy2LL23daily=MathAbs(Body2LL23daily);
                     if(dy2LL23daily<MaxBodyLL23daily && dy2LL23daily>MaxBody2LL23daily)
                       {
                        MaxBody2LL23daily=dy2LL23daily;
                        MaxN2LL23daily=n2LL23daily;
                       }
                     n2LL23daily++;
                    }

                  double darsadLL23daily=(Bodyz3daily/((MaxBodyLL23daily+MaxBody2LL23daily)/2))*100;

                  double candlesizeLL23daily;
                  if(darsadLL23daily>=59)
                     candlesizeLL23daily=4;
                  if(darsadLL23daily<59 && darsadLL23daily>=39)
                     candlesizeLL23daily=3;
                  if(darsadLL23daily<39 && darsadLL23daily>5)
                     candlesizeLL23daily=2;
                  if(darsadLL23daily<=5)
                     candlesizeLL23daily=1;

                  if(ratesWeekly[z3daily].close>LLdaily && candlesizeLL23daily>=3 && downshadowz3daily>=Bodyz3daily && ratesWeekly[z3daily].low<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=ratesWeekly[z3daily].low;
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LD11-"+z3daily,OBJ_VLINE,0,ratesWeekly[z3daily].time,ratesWeekly[z3daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD11-"+z3daily,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesWeekly[z3daily].close>LLdaily && candlesizeLL23daily<3 && downshadowz3daily>=(2*Bodyz3daily) && ratesWeekly[z3daily].low<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=ratesWeekly[z3daily].low;
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LD12-"+z3daily,OBJ_VLINE,0,ratesWeekly[z3daily].time,ratesWeekly[z3daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD12-"+z3daily,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesWeekly[z3daily].close>LLdaily && candlesizeLL23daily>=3 && ratesWeekly[z3daily].low<(LLdaily-(MinLimitdaily)) && (ratesWeekly[z3daily].close>ratesWeekly[z3daily].open))
                    {
                     LL2daily=ratesWeekly[z3daily].low;
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LD13-"+z3daily,OBJ_VLINE,0,ratesWeekly[z3daily].time,ratesWeekly[z3daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD13-"+z3daily,OBJPROP_SELECTABLE,true);
                    }

                  if(z3daily>shoroLdaily && ratesWeekly[z3daily].close<LLdaily && candlesizeLL23daily>=3 && ratesWeekly[z3daily].low<(LLdaily-(MinLimitdaily)) && ratesWeekly[z3daily-1].high>(ratesWeekly[z3daily].close+(0.45*(ratesWeekly[z3daily].open-ratesWeekly[z3daily].close))))
                    {
                     LL2daily=MathMin(ratesWeekly[z3daily].low,ratesWeekly[z3daily-1].low);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LD14-"+z3daily,OBJ_VLINE,0,ratesWeekly[z3daily].time,ratesWeekly[z3daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LD14-"+z3daily,OBJPROP_SELECTABLE,true);
                    }

                 }
              }
            z3daily++;
           }

        }

      if(minLL2daily==LLdaily-((TLdaily-LLdaily)*2))
        {
         int shoroL2daily=iBarShift(NULL,PERIOD_H1,ratesDaily[q].time);
         ObjectCreate(0,"ML shoroLH4L-"+shoroL2daily,OBJ_VLINE,0,ratesDaily[shoroL2daily-1].time,ratesDaily[shoroL2daily-1].low);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2daily,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2daily,OBJPROP_COLOR,Red);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2daily,OBJPROP_HIDDEN,false);
         ObjectSetInteger(0,"ML shoroLH4L-"+shoroL2daily,OBJPROP_SELECTABLE,true);

         int z5daily=shoroL2daily;
         int nz5daily=shoroL2daily;
         int count5daily=0;
         bool mohiti5daily;
         double Bodyz5daily;
         double downshadowz5daily;

         while(z5daily<(Bars(NULL,PERIOD_H1)-1) && count5daily<=MaxTPSLCalcdaily && count5daily<Bars(NULL,PERIOD_H1)-2-z5daily)
           {
              {
               if(ratesDaily[z5daily].high>LLdaily && ratesDaily[z5daily].low<TLdaily)
                 {
                  mohiti5daily=1;
                  count5daily++;
                  ObjectCreate(0,"ML MohitiTH4-"+z5daily,OBJ_ARROW,0,ratesDaily[z5daily].time,ratesDaily[z5daily].low);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5daily,OBJPROP_COLOR,Blue);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5daily,OBJPROP_HIDDEN,false);
                  ObjectSetInteger(0,"ML MohitiTH4-"+z5daily,OBJPROP_SELECTABLE,true);
                 }
               else mohiti5daily=0;
              }

            if(mohiti5daily==1)
              {

               if(ratesDaily[z5daily].low<LLdaily && ratesDaily[z5daily].open>LLdaily)
                 {

                  if(ratesDaily[z5daily].close>ratesDaily[z5daily].open)
                    {
                     downshadowz5daily=MathAbs((ratesDaily[z5daily].low-ratesDaily[z5daily].open+(1*_Point))/_Point);
                    }
                  if(ratesDaily[z5daily].close<ratesDaily[z5daily].open)
                    {
                     downshadowz5daily=MathAbs((ratesDaily[z5daily].low-ratesDaily[z5daily].close+(1*_Point))/_Point);
                    }

                  Bodyz5daily=MathAbs(ratesDaily[z5daily].close-ratesDaily[z5daily].open)/_Point;
                  int nLL25daily=z5daily;
                  int MaxNLL25daily=z5daily;
                  double MaxBodyLL25daily=z5daily;
                  while(nLL25daily<(nOfCandleWdaily+z5daily))
                    {
                     double BodyLL25daily=((ratesDaily[nLL25daily].open-ratesDaily[nLL25daily].close)/_Point);
                     double dyLL25daily=MathAbs(BodyLL25daily);
                     if(dyLL25daily>MaxBodyLL25daily)
                       {
                        MaxBodyLL25daily=dyLL25daily;
                        MaxNLL25daily=nLL25daily;
                       }
                     nLL25daily++;
                    }

                  int n2LL25daily=z5daily;
                  int MaxN2LL25daily=z5daily;
                  double MaxBody2LL25daily=z5daily;
                  while(n2LL25daily<(nOfCandleWdaily+z5daily))
                    {
                     double Body2LL25daily=((ratesDaily[n2LL25daily].open-ratesDaily[n2LL25daily].close)/_Point);
                     double dy2LL25daily=MathAbs(Body2LL25daily);
                     if(dy2LL25daily<MaxBodyLL25daily && dy2LL25daily>MaxBody2LL25daily)
                       {
                        MaxBody2LL25daily=dy2LL25daily;
                        MaxN2LL25daily=n2LL25daily;
                       }
                     n2LL25daily++;
                    }

                  double darsadLL25daily=(Bodyz5daily/((MaxBodyLL25daily+MaxBody2LL25daily)/2))*100;

                  double candlesizeLL25daily;
                  if(darsadLL25daily>=59)
                     candlesizeLL25daily=4;
                  if(darsadLL25daily<59 && darsadLL25daily>=39)
                     candlesizeLL25daily=3;
                  if(darsadLL25daily<39 && darsadLL25daily>5)
                     candlesizeLL25daily=2;
                  if(darsadLL25daily<=5)
                     candlesizeLL25daily=1;

                  if(ratesDaily[z5daily].close>LLdaily && candlesizeLL25daily>=3 && downshadowz5daily>=Bodyz5daily && ratesDaily[z5daily].low<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=ratesDaily[z5daily].low;
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LH41-"+z5daily,OBJ_VLINE,0,ratesDaily[z5daily].time,ratesDaily[z5daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH41-"+z5daily,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z5daily].close>LLdaily && candlesizeLL25daily<3 && downshadowz5daily>=(2*Bodyz5daily) && ratesDaily[z5daily].low<(LLdaily-(MinLimitdaily)))
                    {
                     LL2daily=ratesDaily[z5daily].low;
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LH42-"+z5daily,OBJ_VLINE,0,ratesDaily[z5daily].time,ratesDaily[z5daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH42-"+z5daily,OBJPROP_SELECTABLE,true);
                    }

                  if(ratesDaily[z5daily].close>LLdaily && candlesizeLL25daily>=3 && ratesDaily[z5daily].low<(LLdaily-(MinLimitdaily)) && (ratesDaily[z5daily].close>ratesDaily[z5daily].open))
                    {
                     LL2daily=ratesDaily[z5daily].low;
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LH43-"+z5daily,OBJ_VLINE,0,ratesDaily[z5daily].time,ratesDaily[z5daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH43-"+z5daily,OBJPROP_SELECTABLE,true);
                    }

                  if(z5daily>shoroL2daily && ratesDaily[z5daily].close<LLdaily && candlesizeLL25daily>=3 && ratesDaily[z5daily].low<(LLdaily-(MinLimitdaily)) && ratesDaily[z5daily-1].high>(ratesDaily[z5daily].close+(0.45*(ratesDaily[z5daily].open-ratesDaily[z5daily].close))))
                    {
                     LL2daily=MathMin(ratesDaily[z5daily].low,ratesDaily[z5daily-1].low);
                     if(LL2daily>minLL2daily)minLL2daily=LL2daily;
                     ObjectCreate(0,"ML LL2 Candid LH44-"+z5daily,OBJ_VLINE,0,ratesDaily[z5daily].time,ratesDaily[z5daily].open);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5daily,OBJPROP_STYLE,STYLE_DOT);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5daily,OBJPROP_COLOR,Red);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5daily,OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5daily,OBJPROP_HIDDEN,false);
                     ObjectSetInteger(0,"ML LL2 Candid LH44-"+z5daily,OBJPROP_SELECTABLE,true);
                    }

                 }
              }
            z5daily++;
           }

        }

      int cntTdaily,cntLdaily;
      if(minTL2daily==TLdaily+((TLdaily-LLdaily)*2) && cntTdaily==0)
        {
         Alert(Symbol(),"حد دوم بالا یافت نشد");
         cntTdaily=1;
        }
      if(minLL2daily==LLdaily-((TLdaily-LLdaily)*2) && cntLdaily==0)
        {
         Alert(Symbol(),"حد دوم پایین یافت نشد");
         cntLdaily=1;
        }

      int z_stardaily=q+1;
      int nz_stardaily=q+1;
      double minTL2_stardaily=TLdaily+(600*_Point);
      double TL2_stardaily;

      while(z_stardaily<Bars(NULL,PERIOD_D1)-1)
        {
         if(ratesDaily[z_stardaily].high>(TLdaily+(250*_Point)) && ratesDaily[z_stardaily].close<TLdaily && ratesDaily[z_stardaily].open>LLdaily && ratesDaily[z_stardaily].open<TLdaily)
           {
            TL2_stardaily=ratesDaily[z_stardaily].high;
            if(TL2_stardaily<minTL2_stardaily)minTL2_stardaily=TL2_stardaily;
           }
         z_stardaily++;
        }

      int y_stardaily=q+1;
      int ny_stardaily=q+1;
      double minLL2_stardaily=LLdaily-(600*_Point);
      double LL2_stardaily;
      while(y_stardaily<Bars(NULL,PERIOD_D1)-1)
        {
         if(ratesDaily[y_stardaily].low<(LLdaily-(250*_Point)) && ratesDaily[y_stardaily].close>LLdaily && LLdaily<ratesDaily[y_stardaily].open && ratesDaily[y_stardaily].open<TLdaily)
           {
            LL2_stardaily=ratesDaily[y_stardaily].low;
            if(LL2_stardaily>minLL2_stardaily)minLL2_stardaily=LL2_stardaily;
           }
         y_stardaily++;
        }

      ObjectCreate  (0,"ML Start-"+q, OBJ_VLINE, 0,ratesDaily[q].time+60*60*24*7,0);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger (0,"ML Start-"+q, OBJPROP_TIMEFRAMES, OBJ_PERIOD_H4);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_COLOR,Black);
      ObjectSetInteger (0,"ML Start-"+q,OBJPROP_WIDTH,1);

      ObjectCreate  (0,"ML End-"+q, OBJ_VLINE, 0,ratesDaily[q].time+60*60*24*14,0);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_TIMEFRAMES, OBJ_PERIOD_H4);
      ObjectSetInteger (0,"ML End-"+q,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger (0,"ML End-"+q,OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML End-"+q,OBJPROP_WIDTH,1);

      ObjectCreate(0,"ML starlineT",OBJ_HLINE,0,0,minTL2_stardaily,0,0);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_WIDTH,0);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML starlineT",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML starlineL",OBJ_HLINE,0,0,minLL2_stardaily,0,0);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_WIDTH,0);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML starlineL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML TL",OBJ_HLINE,0,0,TLdaily,0,0);
      ObjectSetInteger(0,"ML TL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML TL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML TL2",OBJ_HLINE,0,0,minTL2daily,0,0);
      ObjectSetInteger(0,"ML TL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML TL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL2",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML LL",OBJ_HLINE,0,0,LLdaily,0,0);
      ObjectSetInteger(0,"ML LL",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML LL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML LL2",OBJ_HLINE,0,0,minLL2daily,0,0);
      ObjectSetInteger(0,"ML LL2",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML LL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL2",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML TL",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"ML TL",OBJPROP_WIDTH,2);
      ObjectSetInteger(0,"ML TL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML LL",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"ML LL",OBJPROP_WIDTH,2);
      ObjectSetInteger(0,"ML LL",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML TL2",OBJPROP_COLOR,Purple);
      ObjectSetInteger(0,"ML TL2",OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML TL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML TL2",OBJPROP_SELECTABLE,true);

      ObjectSetInteger(0,"ML LL2",OBJPROP_COLOR,Purple);
      ObjectSetInteger(0,"ML LL2",OBJPROP_WIDTH,1);
      ObjectSetInteger(0,"ML LL2",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML LL2",OBJPROP_SELECTABLE,true);

      Firstinlinedaily=LLdaily+((TLdaily-LLdaily)/3);
      Secondinlinedaily=LLdaily+(2*(TLdaily-LLdaily)/3);

      ObjectCreate(0,"ML First 0.33",OBJ_HLINE,0,0,Firstinlinedaily,0,0);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML First 0.33",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML Second 0.33",OBJ_HLINE,0,0,Secondinlinedaily,0,0);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1|OBJ_PERIOD_H4|OBJ_PERIOD_H4|OBJ_PERIOD_H1|OBJ_PERIOD_M30|OBJ_PERIOD_H1);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML Second 0.33",OBJPROP_SELECTABLE,true);
      ChartRedraw(0);

      int dirdaily=0;
      string directiondaily;
      int cntdirdaily=0;
      int pdaily=q+1;
      for(pdaily=q+1;pdaily<=10+q; pdaily++)

        {
         if(ratesDaily[pdaily].open<ratesDaily[q].low && cntdirdaily==0)
           {
            directiondaily="صعودی";
            dirdaily=2;
            cntdirdaily=1;
           }
         if(ratesDaily[pdaily].open>ratesDaily[q].high && cntdirdaily==0)
           {
            directiondaily="نزولی";
            dirdaily=0;
            cntdirdaily=1;
           }
        }

      //-----------Jadval Tahlil 1   
      string tahlilAdaily;
      string tahlilBdaily;

      if(dirdaily>1 && bigdaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي،شکست حد بال";
      if(dirdaily>1 && bigdaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirdaily>1 && mediumdaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily>1 && mediumdaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily>1 && smalldaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirdaily>1 && smalldaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily>1 && spinningdaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگو الف : کاهش تمايلات صعودي ، انتظار عدم نواسانات صعودي، شکست حد پايين";
      if(dirdaily>1 && spinningdaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";

      if(dirdaily<1 && bigdaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily<1 && bigdaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily<1 && mediumdaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگو الف: ادامه تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily<1 && mediumdaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگو ب: شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily<1 && smalldaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirdaily<1 && smalldaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";
      if(dirdaily<1 && spinningdaily>=1 && candletypedaily=="تقاضا")
         tahlilAdaily="الگوي الف : شروع تمايلات صعودي ، انتظار نوسانات صعودي ،شکست حد بالا";
      if(dirdaily<1 && spinningdaily>=1 && candletypedaily=="تقاضا")
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي،انتظار نوسانات نزولي، شکست حد پايين";

      if(dirdaily>1 && bigdaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين";
      if(dirdaily>1 && bigdaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily>1 && mediumdaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف: ادامه تمايلات نزولي ، انتظار نوسانات نزولي، شکست حد پايين ";
      if(dirdaily>1 && mediumdaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا ";
      if(dirdaily>1 && smalldaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily>1 && smalldaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";
      if(dirdaily>1 && spinningdaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف : شروع تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily>1 && spinningdaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگو ب: شروع مجدد تمايلات صعودي ، انتظار نوسانات صعودي، شکست حد بالا";

      if(dirdaily<1 && bigdaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirdaily<1 && bigdaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily<1 && mediumdaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف:ادامه تمايلات نزولي ،انتظار نوسانات نزولي ،شکست حد پايين";
      if(dirdaily<1 && mediumdaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگو ب: شروع تمايلات صعودي ، انتظار نوسانات صعودي ، شکست حد بالا";
      if(dirdaily<1 && smalldaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirdaily<1 && smalldaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";
      if(dirdaily<1 && spinningdaily>=1 && candletypedaily=="عرضه")
         tahlilAdaily="الگو الف: کاهش تمايلات نزولي ، انتظار عدم نوسانات نزولي ، شکست حد بالا";
      if(dirdaily<1 && spinningdaily>=1 && candletypedaily=="عرضه")
         tahlilBdaily="الگوي ب: شروع مجدد تمايلات نزولي ، انتظار نوسانات نزولي ، شکست حد پايين";

      ObjectCreate(0,"ML direction",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML direction",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML direction",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML direction",OBJPROP_YDISTANCE,20);
      ObjectSetString(0,"ML direction",OBJPROP_TEXT,directiondaily);
      ObjectSetInteger(0,"ML direction",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML direction",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML direction",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML candletype",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML candletype",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML candletype",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML candletype",OBJPROP_YDISTANCE,35);
      ObjectSetString(0,"ML candletype",OBJPROP_TEXT,candletypedaily);
      ObjectSetInteger(0,"ML candletype",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML candletype",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML candletype",OBJPROP_SELECTABLE,true);

      ObjectCreate(0,"ML X",OBJ_LABEL,0,0,0,0,0);
      ObjectSetInteger(0,"ML X",OBJPROP_CORNER,0);
      ObjectSetInteger(0,"ML X",OBJPROP_XDISTANCE,1000);
      ObjectSetInteger(0,"ML X",OBJPROP_YDISTANCE,50);
      ObjectSetString(0,"ML X",OBJPROP_TEXT,Xdaily);
      ObjectSetInteger(0,"ML X",OBJPROP_FONTSIZE,12);
      ObjectSetInteger(0,"ML X",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML X",OBJPROP_SELECTABLE,true);

      Comment("   جهت اوليه","   ",directiondaily,"\n","   نوع کندل","   ",candletypedaily,"\n","   ","\n  اندازه بدنه کندل مورد ارزيابي:","   ",(badanehdaily),"\n","  اندازه سايه بالا","     ",upshadowdaily,"\n","  اندازه سايه پايين","    ",downshadowdaily,"\n","\n ميانگين دو بزرگترين کندل محيط","   ",(MaxBodydaily+MaxBody2daily)/2,"\n   شماره بزرگترين کندل محيط:","   ",MaxNdaily,"\n   شماره دومين کندل بزرگ محيط:","   ",MaxN2daily,"\n  نسبت بدنه کندل مورد ارزيابي به بدنه مبنا:","   ",Totaldarsaddaily,"\n","  نوع کندل","   ",Xdaily,"\n","\n","   حد احتياط بالا","   ",TLdaily,"\n","   حد احتياط پايين","   ",LLdaily,"\n","\n",tahlilAdaily,"\n",tahlilBdaily);
      //--- create timer
      EventSetTimer(7200);
     }

   string typeofanalysisstring;
   if(typeofanalysis==1) typeofanalysisstring="تحلیل روزانه";
   if(typeofanalysis==2) typeofanalysisstring="تحلیل هفتگی";
   if(typeofanalysis==3) typeofanalysisstring="تحلیل ماهیانه";

   ObjectCreate(0,"ML XtypeA",OBJ_LABEL,0,0,0,0,0);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_CORNER,0);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_XDISTANCE,970);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_YDISTANCE,70);
   ObjectSetString(0,"ML XtypeA",OBJPROP_TEXT,typeofanalysisstring);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_FONTSIZE,14);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_COLOR,Red);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_HIDDEN,false);
   ObjectSetInteger(0,"ML XtypeA",OBJPROP_SELECTABLE,true);

int ppCSV=FileOpen("mostafa",FILE_WRITE|FILE_CSV);
FileWrite(ppCSV,URL);
FileClose (ppCSV);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

   Comment("");
   int  obj_total=ObjectsTotal(0,0,-1);
   for(k=obj_total; k>=0; k--)
     {
      string name=ObjectName(0,k,-1,-1);
      if(StringSubstr(name,0,3)=="ML "){ObjectDelete(0,name);}
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
/*
   MqlRates ratesWeekly[];
   ArraySetAsSeries(ratesWeekly,true);
   int copiedWeekly=CopyRates(NULL,PERIOD_W1,0,Bars(NULL,PERIOD_W1),ratesWeekly);

   MqlRates ratesDaily[];
   ArraySetAsSeries(ratesDaily,true);
   int copiedDaily=CopyRates(NULL,PERIOD_D1,0,Bars(NULL,PERIOD_D1),ratesDaily);

   MqlRates ratesMonthly[];
   ArraySetAsSeries(ratesMonthly,true);
   int copiedMonthly=CopyRates(NULL,PERIOD_MN1,0,Bars(NULL,PERIOD_MN1),ratesMonthly);

   MqlRates ratesH4[];
   ArraySetAsSeries(ratesH4,true);
   int copiedH4=CopyRates(NULL,PERIOD_H4,0,Bars(NULL,PERIOD_H4),ratesH4);

   MqlRates ratesH1[];
   ArraySetAsSeries(ratesH1,true);
   int copiedH1=CopyRates(NULL,PERIOD_H1,0,Bars(NULL,PERIOD_H1),ratesH1);

   string typeofanalysisstring;
   if(typeofanalysis==1) typeofanalysisstring="Daily";
   if(typeofanalysis==2) typeofanalysisstring="Weekly";
   if(typeofanalysis==3) typeofanalysisstring="Monthly";
/
   if(typeofanalysis==2)
     {

      int shoro=iBarShift(NULL,PERIOD_H4,ratesWeekly[q-1].time);
      ObjectCreate(0,"ML StartTradeWeekH4",OBJ_VLINE,0,ratesH4[shoro-1].time,ratesH4[shoro-1].open);
      ObjectSetInteger(0,"ML StartTradeWeekH4",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML StartTradeWeekH4",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML StartTradeWeekH4",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H4);
      ObjectSetInteger(0,"ML StartTradeWeekH4",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML StartTradeWeekH4",OBJPROP_SELECTABLE,true);

      //-------------H4  
      double H4H[30];
      H4H[0]= ratesH4[shoro-1].high;
      H4H[1]= ratesH4[shoro-2].high;
      H4H[2]= ratesH4[shoro-3].high;
      H4H[3]= ratesH4[shoro-4].high;
      H4H[4]= ratesH4[shoro-5].high;
      H4H[5]= ratesH4[shoro-6].high;
      H4H[6]= ratesH4[shoro-7].high;
      H4H[7]= ratesH4[shoro-8].high;
      H4H[8]= ratesH4[shoro-9].high;
      H4H[9]= ratesH4[shoro-10].high;
      H4H[10]= ratesH4[shoro-11].high;
      H4H[11]= ratesH4[shoro-12].high;
      H4H[12]= ratesH4[shoro-13].high;
      H4H[13]= ratesH4[shoro-14].high;
      H4H[14]= ratesH4[shoro-15].high;
      H4H[15]= ratesH4[shoro-16].high;
      H4H[16]= ratesH4[shoro-17].high;
      H4H[17]= ratesH4[shoro-18].high;
      H4H[18]= ratesH4[shoro-19].high;
      H4H[19]= ratesH4[shoro-20].high;
      H4H[20]= ratesH4[shoro-21].high;
      H4H[21]= ratesH4[shoro-22].high;
      H4H[22]= ratesH4[shoro-23].high;
      H4H[23]= ratesH4[shoro-24].high;
      H4H[24]= ratesH4[shoro-25].high;
      H4H[25]= ratesH4[shoro-26].high;
      H4H[26]= ratesH4[shoro-27].high;
      H4H[27]= ratesH4[shoro-28].high;
      H4H[28]= ratesH4[shoro-29].high;
      H4H[29]= ratesH4[shoro-30].high;


      double H4L[30];
      H4L[0]= ratesH4[shoro-1].low;
      H4L[1]= ratesH4[shoro-2].low;
      H4L[2]= ratesH4[shoro-3].low;
      H4L[3]= ratesH4[shoro-4].low;
      H4L[4]= ratesH4[shoro-5].low;
      H4L[5]= ratesH4[shoro-6].low;
      H4L[6]= ratesH4[shoro-7].low;
      H4L[7]= ratesH4[shoro-8].low;
      H4L[8]= ratesH4[shoro-9].low;
      H4L[9]= ratesH4[shoro-10].low;
      H4L[10]= ratesH4[shoro-11].low;
      H4L[11]= ratesH4[shoro-12].low;
      H4L[12]= ratesH4[shoro-13].low;
      H4L[13]= ratesH4[shoro-14].low;
      H4L[14]= ratesH4[shoro-15].low;
      H4L[15]= ratesH4[shoro-16].low;
      H4L[16]= ratesH4[shoro-17].low;
      H4L[17]= ratesH4[shoro-18].low;
      H4L[18]= ratesH4[shoro-19].low;
      H4L[19]= ratesH4[shoro-20].low;
      H4L[20]= ratesH4[shoro-21].low;
      H4L[21]= ratesH4[shoro-22].low;
      H4L[22]= ratesH4[shoro-23].low;
      H4L[23]= ratesH4[shoro-24].low;
      H4L[24]= ratesH4[shoro-25].low;
      H4L[25]= ratesH4[shoro-26].low;
      H4L[26]= ratesH4[shoro-27].low;
      H4L[27]= ratesH4[shoro-28].low;
      H4L[28]= ratesH4[shoro-29].low;
      H4L[29]= ratesH4[shoro-30].low;

      double H4O[30];
      H4O[0]= ratesH4[shoro-1].open;
      H4O[1]= ratesH4[shoro-2].open;
      H4O[2]= ratesH4[shoro-3].open;
      H4O[3]= ratesH4[shoro-4].open;
      H4O[4]= ratesH4[shoro-5].open;
      H4O[5]= ratesH4[shoro-6].open;
      H4O[6]= ratesH4[shoro-7].open;
      H4O[7]= ratesH4[shoro-8].open;
      H4O[8]= ratesH4[shoro-9].open;
      H4O[9]= ratesH4[shoro-10].open;
      H4O[10]= ratesH4[shoro-11].open;
      H4O[11]= ratesH4[shoro-12].open;
      H4O[12]= ratesH4[shoro-13].open;
      H4O[13]= ratesH4[shoro-14].open;
      H4O[14]= ratesH4[shoro-15].open;
      H4O[15]= ratesH4[shoro-16].open;
      H4O[16]= ratesH4[shoro-17].open;
      H4O[17]= ratesH4[shoro-18].open;
      H4O[18]= ratesH4[shoro-19].open;
      H4O[19]= ratesH4[shoro-20].open;
      H4O[20]= ratesH4[shoro-21].open;
      H4O[21]= ratesH4[shoro-22].open;
      H4O[22]= ratesH4[shoro-23].open;
      H4O[23]= ratesH4[shoro-24].open;
      H4O[24]= ratesH4[shoro-25].open;
      H4O[25]= ratesH4[shoro-26].open;
      H4O[26]= ratesH4[shoro-27].open;
      H4O[27]= ratesH4[shoro-28].open;
      H4O[28]= ratesH4[shoro-29].open;
      H4O[29]= ratesH4[shoro-30].open;

      double H4C[30];
      H4C[0]= ratesH4[shoro-1].close;
      H4C[1]= ratesH4[shoro-2].close;
      H4C[2]= ratesH4[shoro-3].close;
      H4C[3]= ratesH4[shoro-4].close;
      H4C[4]= ratesH4[shoro-5].close;
      H4C[5]= ratesH4[shoro-6].close;
      H4C[6]= ratesH4[shoro-7].close;
      H4C[7]= ratesH4[shoro-8].close;
      H4C[8]= ratesH4[shoro-9].close;
      H4C[9]= ratesH4[shoro-10].close;
      H4C[10]= ratesH4[shoro-11].close;
      H4C[11]= ratesH4[shoro-12].close;
      H4C[12]= ratesH4[shoro-13].close;
      H4C[13]= ratesH4[shoro-14].close;
      H4C[14]= ratesH4[shoro-15].close;
      H4C[15]= ratesH4[shoro-16].close;
      H4C[16]= ratesH4[shoro-17].close;
      H4C[17]= ratesH4[shoro-18].close;
      H4C[18]= ratesH4[shoro-19].close;
      H4C[19]= ratesH4[shoro-20].close;
      H4C[20]= ratesH4[shoro-21].close;
      H4C[21]= ratesH4[shoro-22].close;
      H4C[22]= ratesH4[shoro-23].close;
      H4C[23]= ratesH4[shoro-24].close;
      H4C[24]= ratesH4[shoro-25].close;
      H4C[25]= ratesH4[shoro-26].close;
      H4C[26]= ratesH4[shoro-27].close;
      H4C[27]= ratesH4[shoro-28].close;
      H4C[28]= ratesH4[shoro-29].close;
      H4C[29]= ratesH4[shoro-30].close;
      //-----------------
      int shoroD1=iBarShift(NULL,PERIOD_D1,ratesWeekly[q-1].time);
      ObjectCreate(0,"ML StartTradeWeekD1",OBJ_VLINE,0,ratesDaily[shoroD1-1].time,ratesDaily[shoroD1-1].open);
      ObjectSetInteger(0,"ML StartTradeWeekD1",OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,"ML StartTradeWeekD1",OBJPROP_COLOR,Green);
      ObjectSetInteger(0,"ML StartTradeWeekD1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);
      ObjectSetInteger(0,"ML StartTradeWeekD1",OBJPROP_HIDDEN,false);
      ObjectSetInteger(0,"ML StartTradeWeekD1",OBJPROP_SELECTABLE,true);

      //-------------D1  
      double D1H[5];
      D1H[0]= ratesDaily[shoroD1-1].high;
      D1H[1]= ratesDaily[shoroD1-2].high;
      D1H[2]= ratesDaily[shoroD1-3].high;
      D1H[3]= ratesDaily[shoroD1-4].high;
      D1H[4]= ratesDaily[shoroD1-5].high;


      double D1L[5];
      D1L[0]= ratesDaily[shoroD1-1].low;
      D1L[1]= ratesDaily[shoroD1-2].low;
      D1L[2]= ratesDaily[shoroD1-3].low;
      D1L[3]= ratesDaily[shoroD1-4].low;
      D1L[4]= ratesDaily[shoroD1-5].low;

      double D1O[5];
      D1O[0]= ratesDaily[shoroD1-1].open;
      D1O[1]= ratesDaily[shoroD1-2].open;
      D1O[2]= ratesDaily[shoroD1-3].open;
      D1O[3]= ratesDaily[shoroD1-4].open;
      D1O[4]= ratesDaily[shoroD1-5].open;

      double D1C[5];
      D1C[0]= ratesDaily[shoroD1-1].close;
      D1C[1]= ratesDaily[shoroD1-2].close;
      D1C[2]= ratesDaily[shoroD1-3].close;
      D1C[3]= ratesDaily[shoroD1-4].close;
      D1C[4]= ratesDaily[shoroD1-5].close;

      bool dailyzoneprice[5][7];
      //---D1
      if(D1H[0]>minTL2)dailyzoneprice[0][0]=1;
      if(D1H[0]>TL && D1H[0]<minTL2)dailyzoneprice[0][1]=1;
      if(D1H[0]<TL && D1H[0]>Secondinline)dailyzoneprice[0][2]=1;
      if(D1H[0]<Secondinline && D1H[0]>Firstinline)dailyzoneprice[0][3]=1;
      if(D1H[0]<Firstinline && D1H[0]>LL)dailyzoneprice[0][4]=1;
      if(D1H[0]<LL && D1H[0]>minLL2)dailyzoneprice[0][5]=1;
      if(D1H[0]<minLL2)dailyzoneprice[0][6]=1;

      if(D1L[0]>minTL2)dailyzoneprice[0][0]=1;
      if(D1L[0]>TL && D1H[0]<minTL2)dailyzoneprice[0][1]=1;
      if(D1L[0]<TL && D1H[0]>Secondinline)dailyzoneprice[0][2]=1;
      if(D1L[0]<Secondinline && D1H[0]>Firstinline)dailyzoneprice[0][3]=1;
      if(D1L[0]<Firstinline && D1H[0]>LL)dailyzoneprice[0][4]=1;
      if(D1L[0]<LL && D1H[0]>minLL2)dailyzoneprice[0][5]=1;
      if(D1L[0]<minLL2)dailyzoneprice[0][6]=1;

      if(D1H[0]>minTL2 && D1L[0]<TL)dailyzoneprice[0][1]=1;
      if(D1H[0]>TL && D1L[0]<Secondinline)dailyzoneprice[0][2]=1;
      if(D1H[0]>Secondinline && D1L[0]<Firstinline)dailyzoneprice[0][3]=1;
      if(D1H[0]>Firstinline && D1L[0]<LL)dailyzoneprice[0][4]=1;
      if(D1H[0]>LL && D1L[0]<minLL2)dailyzoneprice[0][5]=1;

      //---D2
      if(D1H[1]>minTL2)dailyzoneprice[1][0]=1;
      if(D1H[1]>TL && D1H[1]<minTL2)dailyzoneprice[1][1]=1;
      if(D1H[1]<TL && D1H[1]>Secondinline)dailyzoneprice[1][2]=1;
      if(D1H[1]<Secondinline && D1H[1]>Firstinline)dailyzoneprice[1][3]=1;
      if(D1H[1]<Firstinline && D1H[1]>LL)dailyzoneprice[1][4]=1;
      if(D1H[1]<LL && D1H[1]>minLL2)dailyzoneprice[1][5]=1;
      if(D1H[1]<minLL2)dailyzoneprice[1][6]=1;

      if(D1L[1]>minTL2)dailyzoneprice[1][0]=1;
      if(D1L[1]>TL && D1H[1]<minTL2)dailyzoneprice[1][1]=1;
      if(D1L[1]<TL && D1H[1]>Secondinline)dailyzoneprice[1][2]=1;
      if(D1L[1]<Secondinline && D1H[1]>Firstinline)dailyzoneprice[1][3]=1;
      if(D1L[1]<Firstinline && D1H[1]>LL)dailyzoneprice[1][4]=1;
      if(D1L[1]<LL && D1H[1]>minLL2)dailyzoneprice[1][5]=1;
      if(D1L[1]<minLL2)dailyzoneprice[1][6]=1;

      if(D1H[1]>minTL2 && D1L[1]<TL)dailyzoneprice[1][1]=1;
      if(D1H[1]>TL && D1L[1]<Secondinline)dailyzoneprice[1][2]=1;
      if(D1H[1]>Secondinline && D1L[1]<Firstinline)dailyzoneprice[1][3]=1;
      if(D1H[1]>Firstinline && D1L[1]<LL)dailyzoneprice[1][4]=1;
      if(D1H[1]>LL && D1L[1]<minLL2)dailyzoneprice[1][5]=1;

      //---D3
      if(D1H[2]>minTL2)dailyzoneprice[2][0]=1;
      if(D1H[2]>TL && D1H[2]<minTL2)dailyzoneprice[2][1]=1;
      if(D1H[2]<TL && D1H[2]>Secondinline)dailyzoneprice[2][2]=1;
      if(D1H[2]<Secondinline && D1H[2]>Firstinline)dailyzoneprice[2][3]=1;
      if(D1H[2]<Firstinline && D1H[2]>LL)dailyzoneprice[2][4]=1;
      if(D1H[2]<LL && D1H[2]>minLL2)dailyzoneprice[2][5]=1;
      if(D1H[2]<minLL2)dailyzoneprice[2][6]=1;

      if(D1L[2]>minTL2)dailyzoneprice[2][0]=1;
      if(D1L[2]>TL && D1H[2]<minTL2)dailyzoneprice[2][1]=1;
      if(D1L[2]<TL && D1H[2]>Secondinline)dailyzoneprice[2][2]=1;
      if(D1L[2]<Secondinline && D1H[2]>Firstinline)dailyzoneprice[2][3]=1;
      if(D1L[2]<Firstinline && D1H[2]>LL)dailyzoneprice[2][4]=1;
      if(D1L[2]<LL && D1H[2]>minLL2)dailyzoneprice[2][5]=1;
      if(D1L[2]<minLL2)dailyzoneprice[2][6]=1;

      if(D1H[2]>minTL2 && D1L[2]<TL)dailyzoneprice[2][1]=1;
      if(D1H[2]>TL && D1L[2]<Secondinline)dailyzoneprice[2][2]=1;
      if(D1H[2]>Secondinline && D1L[2]<Firstinline)dailyzoneprice[2][3]=1;
      if(D1H[2]>Firstinline && D1L[2]<LL)dailyzoneprice[2][4]=1;
      if(D1H[2]>LL && D1L[2]<minLL2)dailyzoneprice[2][5]=1;

      //---D4
      if(D1H[3]>minTL2)dailyzoneprice[3][0]=1;
      if(D1H[3]>TL && D1H[3]<minTL2)dailyzoneprice[3][1]=1;
      if(D1H[3]<TL && D1H[3]>Secondinline)dailyzoneprice[3][2]=1;
      if(D1H[3]<Secondinline && D1H[3]>Firstinline)dailyzoneprice[3][3]=1;
      if(D1H[3]<Firstinline && D1H[3]>LL)dailyzoneprice[3][4]=1;
      if(D1H[3]<LL && D1H[3]>minLL2)dailyzoneprice[3][5]=1;
      if(D1H[3]<minLL2)dailyzoneprice[3][6]=1;

      if(D1L[3]>minTL2)dailyzoneprice[3][0]=1;
      if(D1L[3]>TL && D1H[3]<minTL2)dailyzoneprice[3][1]=1;
      if(D1L[3]<TL && D1H[3]>Secondinline)dailyzoneprice[3][2]=1;
      if(D1L[3]<Secondinline && D1H[3]>Firstinline)dailyzoneprice[3][3]=1;
      if(D1L[3]<Firstinline && D1H[3]>LL)dailyzoneprice[3][4]=1;
      if(D1L[3]<LL && D1H[3]>minLL2)dailyzoneprice[3][5]=1;
      if(D1L[3]<minLL2)dailyzoneprice[3][6]=1;

      if(D1H[3]>minTL2 && D1L[3]<TL)dailyzoneprice[3][1]=1;
      if(D1H[3]>TL && D1L[3]<Secondinline)dailyzoneprice[3][2]=1;
      if(D1H[3]>Secondinline && D1L[3]<Firstinline)dailyzoneprice[3][3]=1;
      if(D1H[3]>Firstinline && D1L[3]<LL)dailyzoneprice[3][4]=1;
      if(D1H[3]>LL && D1L[3]<minLL2)dailyzoneprice[3][5]=1;

      //---D5
      if(D1H[4]>minTL2)dailyzoneprice[4][0]=1;
      if(D1H[4]>TL && D1H[4]<minTL2)dailyzoneprice[4][1]=1;
      if(D1H[4]<TL && D1H[4]>Secondinline)dailyzoneprice[4][2]=1;
      if(D1H[4]<Secondinline && D1H[4]>Firstinline)dailyzoneprice[4][3]=1;
      if(D1H[4]<Firstinline && D1H[4]>LL)dailyzoneprice[4][4]=1;
      if(D1H[4]<LL && D1H[4]>minLL2)dailyzoneprice[4][5]=1;
      if(D1H[4]<minLL2)dailyzoneprice[4][6]=1;

      if(D1L[4]>minTL2)dailyzoneprice[4][0]=1;
      if(D1L[4]>TL && D1H[4]<minTL2)dailyzoneprice[4][1]=1;
      if(D1L[4]<TL && D1H[4]>Secondinline)dailyzoneprice[4][2]=1;
      if(D1L[4]<Secondinline && D1H[4]>Firstinline)dailyzoneprice[4][3]=1;
      if(D1L[4]<Firstinline && D1H[4]>LL)dailyzoneprice[4][4]=1;
      if(D1L[4]<LL && D1H[4]>minLL2)dailyzoneprice[4][5]=1;
      if(D1L[4]<minLL2)dailyzoneprice[4][6]=1;

      if(D1H[4]>minTL2 && D1L[4]<TL)dailyzoneprice[4][1]=1;
      if(D1H[4]>TL && D1L[4]<Secondinline)dailyzoneprice[4][2]=1;
      if(D1H[4]>Secondinline && D1L[4]<Firstinline)dailyzoneprice[4][3]=1;
      if(D1H[4]>Firstinline && D1L[4]<LL)dailyzoneprice[4][4]=1;
      if(D1H[4]>LL && D1L[4]<minLL2)dailyzoneprice[4][5]=1;

      int PPWeekD[6];

      //---------[0]
      double iclosedaily0=ratesDaily[shoroD1].close;
      if(iclosedaily0>TL2)PPWeekD[0]=7;
      if(iclosedaily0>TL && iclosedaily0<TL2)PPWeekD[0]=6;
      if(iclosedaily0<TL && iclosedaily0>Secondinline)PPWeekD[0]=5;
      if(iclosedaily0<Secondinline && iclosedaily0>Firstinline)PPWeekD[0]=4;
      if(iclosedaily0<Firstinline && iclosedaily0>LL)PPWeekD[0]=3;
      if(iclosedaily0<LL && iclosedaily0>LL2)PPWeekD[0]=2;
      if(iclosedaily0<LL2)PPWeekD[0]=1;
      if(iclosedaily0==0)PPWeekD[0]=0;
      //---------[1]
      double iclosedaily1=ratesDaily[shoroD1-1].close;
      if(iclosedaily1>TL2)PPWeekD[1]=7;
      if(iclosedaily1>TL && iclosedaily1<TL2)PPWeekD[1]=6;
      if(iclosedaily1<TL && iclosedaily1>Secondinline)PPWeekD[1]=5;
      if(iclosedaily1<Secondinline && iclosedaily1>Firstinline)PPWeekD[1]=4;
      if(iclosedaily1<Firstinline && iclosedaily1>LL)PPWeekD[1]=3;
      if(iclosedaily1<LL && iclosedaily1>LL2)PPWeekD[1]=2;
      if(iclosedaily1<LL2)PPWeekD[1]=1;
      if(iclosedaily1==0)PPWeekD[1]=0;
      //---------[2]
      double iclosedaily2=ratesDaily[shoroD1-2].close;
      if(iclosedaily2>TL2)PPWeekD[2]=7;
      if(iclosedaily2>TL && iclosedaily2<TL2)PPWeekD[2]=6;
      if(iclosedaily2<TL && iclosedaily2>Secondinline)PPWeekD[2]=5;
      if(iclosedaily2<Secondinline && iclosedaily2>Firstinline)PPWeekD[2]=4;
      if(iclosedaily2<Firstinline && iclosedaily2>LL)PPWeekD[2]=3;
      if(iclosedaily2<LL && iclosedaily2>LL2)PPWeekD[2]=2;
      if(iclosedaily2<LL2)PPWeekD[2]=1;
      if(iclosedaily2==0)PPWeekD[2]=0;
      //---------[3]
      double iclosedaily3=ratesDaily[shoroD1-3].close;
      if(iclosedaily3>TL2)PPWeekD[3]=7;
      if(iclosedaily3>TL && iclosedaily3<TL2)PPWeekD[3]=6;
      if(iclosedaily3<TL && iclosedaily3>Secondinline)PPWeekD[3]=5;
      if(iclosedaily3<Secondinline && iclosedaily3>Firstinline)PPWeekD[3]=4;
      if(iclosedaily3<Firstinline && iclosedaily3>LL)PPWeekD[3]=3;
      if(iclosedaily3<LL && iclosedaily3>LL2)PPWeekD[3]=2;
      if(iclosedaily3<LL2)PPWeekD[3]=1;
      if(iclosedaily3==0)PPWeekD[3]=0;
      //---------[4]
      double iclosedaily4=ratesDaily[shoroD1-4].close;
      if(iclosedaily4>TL2)PPWeekD[4]=7;
      if(iclosedaily4>TL && iclosedaily4<TL2)PPWeekD[4]=6;
      if(iclosedaily4<TL && iclosedaily4>Secondinline)PPWeekD[4]=5;
      if(iclosedaily4<Secondinline && iclosedaily4>Firstinline)PPWeekD[4]=4;
      if(iclosedaily4<Firstinline && iclosedaily4>LL)PPWeekD[4]=3;
      if(iclosedaily4<LL && iclosedaily4>LL2)PPWeekD[4]=2;
      if(iclosedaily4<LL2)PPWeekD[4]=1;
      if(iclosedaily4==0)PPWeekD[4]=0;
      //---------[5]
      double iclosedaily5=ratesDaily[shoroD1-5].close;
      if(iclosedaily5>TL2)PPWeekD[5]=7;
      if(iclosedaily5>TL && iclosedaily5<TL2)PPWeekD[5]=6;
      if(iclosedaily5<TL && iclosedaily5>Secondinline)PPWeekD[5]=5;
      if(iclosedaily5<Secondinline && iclosedaily5>Firstinline)PPWeekD[5]=4;
      if(iclosedaily5<Firstinline && iclosedaily5>LL)PPWeekD[5]=3;
      if(iclosedaily5<LL && iclosedaily5>LL2)PPWeekD[5]=2;
      if(iclosedaily5<LL2)PPWeekD[5]=1;
      if(iclosedaily5==0)PPWeekD[5]=0;

      int n;
      if(Break2StatusT==0)
        {
         for(n=0;n<=29; n++)
           {
            if(NoCloseU<2)
              {
               if(H4C[n]>TL && H4C[n]>0 && ratesH4[0].open!=H4O[n])
                 {
                  NoCloseU++;
                  if(NoCloseU>=2)
                    {
                     SendNotification(Symbol()+typeofanalysisstring+" Main Break happend on TL");
                     Break2StatusT=1;
                    }

                 }
              }
           }
        }
      if(Break2StatusT==0 && Break1StatusT==0)
        {
         for(n=0;n<=29; n++)
           {
            if(H4H[n]>TL && H4H[n]>0 && NoCloseU<2)
              {
               if(countpush1>=0)
                 {
                  SendNotification(Symbol()+typeofanalysisstring+" First Break happend on TL");
                  Break1StatusT=1;
                  countpush1--;

                 }
              }
           }
        }
      if(Break2StatusL==0)
        {
         for(n=0;n<=29; n++)
           {
            if(NoCloseD<2)
              {
               if(H4C[n]<LL && H4C[n]>0 && NoCloseD<2 && ratesH4[0].open!=H4O[n])
                 {
                  NoCloseD++;
                  if(NoCloseD==2)
                    {
                     SendNotification(Symbol()+typeofanalysisstring+" Main Break happend on LL");
                     Break2StatusL=1;
                    }

                 }
              }
           }
        }

      if(Break2StatusL==0 && Break1StatusL==0)
        {
         for(n=0;n<=29; n++)
           {
            if(H4L[n]<LL && H4L[n]>0)
              {
               if(countpush2>=0)
                 {
                  SendNotification(Symbol()+typeofanalysisstring+" First Break happend on LL");
                  Break1StatusL=1;
                  countpush2--;
                 }
              }
           }
        }
      //----------------------------------------------------------------------+     
      double icloseH4_Current=ratesH4[0].close;
      if(icloseH4_Current>TL2)
        {
         priceposition=7;
         pp="Higher than TL2";
        }
      if(icloseH4_Current>TL && icloseH4_Current<TL2)
        {
         priceposition=6;
         pp="Between TL2 and TL";
        }
      if(icloseH4_Current<TL && icloseH4_Current>Secondinline)
        {
         priceposition=5;
         pp="Upper 1/3 Zone";
        }
      if(icloseH4_Current<Secondinline && icloseH4_Current>Firstinline)
        {
         priceposition=4;
         pp="In middle 1/3 zone";
        }
      if(icloseH4_Current<Firstinline && icloseH4_Current>LL)
        {
         priceposition=3;
         pp="Lower 1/3 zone";
        }
      if(icloseH4_Current<LL && icloseH4_Current>LL2)
        {
         priceposition=2;
         pp="between LL and LL2";
        }
      if(icloseH4_Current<LL2)
        {
         priceposition=1;
         pp="Lower than LL2";
        }
      //-------------------------------------------------------------------+    

      int ppCSV=FileOpen(sym+TimeToString(ratesWeekly[q-1].time,TIME_DATE),FILE_WRITE|FILE_CSV);
      FileWrite(ppCSV,sym,IntegerToString(dailyzoneprice[0][0],0),IntegerToString(dailyzoneprice[1][0],0),IntegerToString(dailyzoneprice[2][0],0),IntegerToString(dailyzoneprice[3][0],0),IntegerToString(dailyzoneprice[4][0],0));
      FileWrite(ppCSV,TimeToString(ratesWeekly[q-1].time,TIME_DATE),IntegerToString(dailyzoneprice[0][1],0),IntegerToString(dailyzoneprice[1][1],0),IntegerToString(dailyzoneprice[2][1],0),IntegerToString(dailyzoneprice[3][1],0),IntegerToString(dailyzoneprice[4][1],0));
      FileWrite(ppCSV,"",IntegerToString(dailyzoneprice[0][2],0),IntegerToString(dailyzoneprice[1][2],0),IntegerToString(dailyzoneprice[2][2],0),IntegerToString(dailyzoneprice[3][2],0),IntegerToString(dailyzoneprice[4][2],0));
      FileWrite(ppCSV,"",IntegerToString(dailyzoneprice[0][3],0),IntegerToString(dailyzoneprice[1][3],0),IntegerToString(dailyzoneprice[2][3],0),IntegerToString(dailyzoneprice[3][3],0),IntegerToString(dailyzoneprice[4][3],0));
      FileWrite(ppCSV,"",IntegerToString(dailyzoneprice[0][4],0),IntegerToString(dailyzoneprice[1][4],0),IntegerToString(dailyzoneprice[2][4],0),IntegerToString(dailyzoneprice[3][4],0),IntegerToString(dailyzoneprice[4][4],0));
      FileWrite(ppCSV,"",IntegerToString(dailyzoneprice[0][5],0),IntegerToString(dailyzoneprice[1][5],0),IntegerToString(dailyzoneprice[2][5],0),IntegerToString(dailyzoneprice[3][5],0),IntegerToString(dailyzoneprice[4][5],0));
      FileWrite(ppCSV,"",IntegerToString(dailyzoneprice[0][6],0),IntegerToString(dailyzoneprice[1][6],0),IntegerToString(dailyzoneprice[2][6],0),IntegerToString(dailyzoneprice[3][6],0),IntegerToString(dailyzoneprice[4][6],0));
      FileClose(ppCSV);

     }

//-------------------------Monthly-------------------------+    
   if(typeofanalysis==3)
     {
      int shoromonthly=iBarShift(NULL,PERIOD_D1,iTime(NULL,PERIOD_MN1,q-1));
      ObjectCreate("ML StartTradeWeekH4",OBJ_VLINE,0,iTime(NULL,PERIOD_D1,shoromonthly-1),iOpen(NULL,PERIOD_D1,shoromonthly-1));
      ObjectSet("ML StartTradeWeekH4",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH4",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH4",OBJPROP_TIMEFRAMES,OBJ_PERIOD_D1);

      //-------------D1 
      double M_D1H[20];
      M_D1H[0]= iHigh(NULL,PERIOD_D1,shoromonthly-1);
      M_D1H[1]= iHigh(NULL,PERIOD_D1,shoromonthly-2);
      M_D1H[2]= iHigh(NULL,PERIOD_D1,shoromonthly-3);
      M_D1H[3]= iHigh(NULL,PERIOD_D1,shoromonthly-4);
      M_D1H[4]= iHigh(NULL,PERIOD_D1,shoromonthly-5);
      M_D1H[5]= iHigh(NULL,PERIOD_D1,shoromonthly-6);
      M_D1H[6]= iHigh(NULL,PERIOD_D1,shoromonthly-7);
      M_D1H[7]= iHigh(NULL,PERIOD_D1,shoromonthly-8);
      M_D1H[8]= iHigh(NULL,PERIOD_D1,shoromonthly-9);
      M_D1H[9]= iHigh(NULL,PERIOD_D1,shoromonthly-10);
      M_D1H[10]= iHigh(NULL,PERIOD_D1,shoromonthly-11);
      M_D1H[11]= iHigh(NULL,PERIOD_D1,shoromonthly-12);
      M_D1H[12]= iHigh(NULL,PERIOD_D1,shoromonthly-13);
      M_D1H[13]= iHigh(NULL,PERIOD_D1,shoromonthly-14);
      M_D1H[14]= iHigh(NULL,PERIOD_D1,shoromonthly-15);
      M_D1H[15]= iHigh(NULL,PERIOD_D1,shoromonthly-16);
      M_D1H[16]= iHigh(NULL,PERIOD_D1,shoromonthly-17);
      M_D1H[17]= iHigh(NULL,PERIOD_D1,shoromonthly-18);
      M_D1H[18]= iHigh(NULL,PERIOD_D1,shoromonthly-19);
      M_D1H[19]= iHigh(NULL,PERIOD_D1,shoromonthly-20);


      double M_D1L[20];
      M_D1L[0]= iLow(NULL,PERIOD_D1,shoromonthly-1);
      M_D1L[1]= iLow(NULL,PERIOD_D1,shoromonthly-2);
      M_D1L[2]= iLow(NULL,PERIOD_D1,shoromonthly-3);
      M_D1L[3]= iLow(NULL,PERIOD_D1,shoromonthly-4);
      M_D1L[4]= iLow(NULL,PERIOD_D1,shoromonthly-5);
      M_D1L[5]= iLow(NULL,PERIOD_D1,shoromonthly-6);
      M_D1L[6]= iLow(NULL,PERIOD_D1,shoromonthly-7);
      M_D1L[7]= iLow(NULL,PERIOD_D1,shoromonthly-8);
      M_D1L[8]= iLow(NULL,PERIOD_D1,shoromonthly-9);
      M_D1L[9]= iLow(NULL,PERIOD_D1,shoromonthly-10);
      M_D1L[10]= iLow(NULL,PERIOD_D1,shoromonthly-11);
      M_D1L[11]= iLow(NULL,PERIOD_D1,shoromonthly-12);
      M_D1L[12]= iLow(NULL,PERIOD_D1,shoromonthly-13);
      M_D1L[13]= iLow(NULL,PERIOD_D1,shoromonthly-14);
      M_D1L[14]= iLow(NULL,PERIOD_D1,shoromonthly-15);
      M_D1L[15]= iLow(NULL,PERIOD_D1,shoromonthly-16);
      M_D1L[16]= iLow(NULL,PERIOD_D1,shoromonthly-17);
      M_D1L[17]= iLow(NULL,PERIOD_D1,shoromonthly-18);
      M_D1L[18]= iLow(NULL,PERIOD_D1,shoromonthly-19);
      M_D1L[19]= iLow(NULL,PERIOD_D1,shoromonthly-20);

      double M_D1O[20];
      M_D1O[0]= iOpen(NULL,PERIOD_D1,shoromonthly-1);
      M_D1O[1]= iOpen(NULL,PERIOD_D1,shoromonthly-2);
      M_D1O[2]= iOpen(NULL,PERIOD_D1,shoromonthly-3);
      M_D1O[3]= iOpen(NULL,PERIOD_D1,shoromonthly-4);
      M_D1O[4]= iOpen(NULL,PERIOD_D1,shoromonthly-5);
      M_D1O[5]= iOpen(NULL,PERIOD_D1,shoromonthly-6);
      M_D1O[6]= iOpen(NULL,PERIOD_D1,shoromonthly-7);
      M_D1O[7]= iOpen(NULL,PERIOD_D1,shoromonthly-8);
      M_D1O[8]= iOpen(NULL,PERIOD_D1,shoromonthly-9);
      M_D1O[9]= iOpen(NULL,PERIOD_D1,shoromonthly-10);
      M_D1O[10]= iOpen(NULL,PERIOD_D1,shoromonthly-11);
      M_D1O[11]= iOpen(NULL,PERIOD_D1,shoromonthly-12);
      M_D1O[12]= iOpen(NULL,PERIOD_D1,shoromonthly-13);
      M_D1O[13]= iOpen(NULL,PERIOD_D1,shoromonthly-14);
      M_D1O[14]= iOpen(NULL,PERIOD_D1,shoromonthly-15);
      M_D1O[15]= iOpen(NULL,PERIOD_D1,shoromonthly-16);
      M_D1O[16]= iOpen(NULL,PERIOD_D1,shoromonthly-17);
      M_D1O[17]= iOpen(NULL,PERIOD_D1,shoromonthly-18);
      M_D1O[18]= iOpen(NULL,PERIOD_D1,shoromonthly-19);
      M_D1O[19]= iOpen(NULL,PERIOD_D1,shoromonthly-20);

      double M_D1C[29];
      M_D1C[0]= iClose(NULL,PERIOD_D1,shoromonthly-1);
      M_D1C[1]= iClose(NULL,PERIOD_D1,shoromonthly-2);
      M_D1C[2]= iClose(NULL,PERIOD_D1,shoromonthly-3);
      M_D1C[3]= iClose(NULL,PERIOD_D1,shoromonthly-4);
      M_D1C[4]= iClose(NULL,PERIOD_D1,shoromonthly-5);
      M_D1C[5]= iClose(NULL,PERIOD_D1,shoromonthly-6);
      M_D1C[6]= iClose(NULL,PERIOD_D1,shoromonthly-7);
      M_D1C[7]= iClose(NULL,PERIOD_D1,shoromonthly-8);
      M_D1C[8]= iClose(NULL,PERIOD_D1,shoromonthly-9);
      M_D1C[9]= iClose(NULL,PERIOD_D1,shoromonthly-10);
      M_D1C[10]= iClose(NULL,PERIOD_D1,shoromonthly-11);
      M_D1C[11]= iClose(NULL,PERIOD_D1,shoromonthly-12);
      M_D1C[12]= iClose(NULL,PERIOD_D1,shoromonthly-13);
      M_D1C[13]= iClose(NULL,PERIOD_D1,shoromonthly-14);
      M_D1C[14]= iClose(NULL,PERIOD_D1,shoromonthly-15);
      M_D1C[15]= iClose(NULL,PERIOD_D1,shoromonthly-16);
      M_D1C[16]= iClose(NULL,PERIOD_D1,shoromonthly-17);
      M_D1C[17]= iClose(NULL,PERIOD_D1,shoromonthly-18);
      M_D1C[18]= iClose(NULL,PERIOD_D1,shoromonthly-19);
      M_D1C[19]= iClose(NULL,PERIOD_D1,shoromonthly-20);

      //-----------------

      int nmonthly;
      if(Break2StatusTmonthly==0)
        {
         for(nmonthly=0;nmonthly<=19; nmonthly++)
           {
            if(NoCloseUmonthly<2)
              {
               if(M_D1C[nmonthly]>TLmonthly && M_D1C[nmonthly]>0 && iOpen(NULL,PERIOD_D1,0)!=M_D1O[nmonthly])
                 {
                  NoCloseUmonthly++;
                  if(NoCloseUmonthly>=2 && marketopenclose==1)
                    {
                     SendNotification(Symbol()+typeofanalysisstring+" Main Break happend on TL");
                     Break2StatusTmonthly=1;
                    }

                 }
              }
           }
        }
      if(Break2StatusTmonthly==0 && Break1StatusTmonthly==0)
        {
         for(nmonthly=0;nmonthly<=19; nmonthly++)
           {
            if(M_D1H[nmonthly]>TLmonthly && M_D1H[nmonthly]>0 && NoCloseUmonthly<2)
              {
               if(countpush1monthly>=0 && marketopenclose==1)
                 {
                  SendNotification(Symbol()+typeofanalysisstring+" First Break happend on TL");
                  Break1StatusTmonthly=1;
                  countpush1monthly--;

                 }
              }
           }
        }
      if(Break2StatusLmonthly==0)
        {
         for(nmonthly=0;nmonthly<=19; nmonthly++)
           {
            if(NoCloseDmonthly<2)
              {
               if(M_D1C[nmonthly]<LLmonthly && M_D1C[nmonthly]>0 && NoCloseDmonthly<2 && iOpen(NULL,PERIOD_D1,0)!=M_D1O[nmonthly])
                 {
                  NoCloseDmonthly++;
                  if(NoCloseDmonthly==2 && marketopenclose==1)
                    {
                     SendNotification(Symbol()+typeofanalysisstring+" Main Break happend on LL");
                     Break2StatusLmonthly=1;
                    }

                 }
              }
           }
        }

      if(Break2StatusLmonthly==0 && Break1StatusLmonthly==0)
        {
         for(nmonthly=0;nmonthly<=19; nmonthly++)
           {
            if(M_D1L[nmonthly]<LLmonthly && M_D1L[nmonthly]>0)
              {
               if(countpush2monthly>=0 && marketopenclose==1)
                 {
                  SendNotification(Symbol()+typeofanalysisstring+" First Break happend on LL");
                  Break1StatusLmonthly=1;
                  countpush2monthly--;
                 }
              }
           }
        }
      //----------------------------------------------------------------------+     
      double icloseD1_Current=iClose(NULL,PERIOD_D1,0);
      if(icloseD1_Current>TL2monthly)
        {
         priceposition=7;
         pp="Higher than TL2";
        }
      if(icloseD1_Current>TLmonthly && icloseD1_Current<TL2monthly)
        {
         priceposition=6;
         pp="Between TL2 and TL";
        }
      if(icloseD1_Current<TLmonthly && icloseD1_Current>Secondinlinemonthly)
        {
         priceposition=5;
         pp="Upper 1/3 Zone";
        }
      if(icloseD1_Current<Secondinlinemonthly && icloseD1_Current>Firstinlinemonthly)
        {
         priceposition=4;
         pp="In middle 1/3 zone";
        }
      if(icloseD1_Current<Firstinlinemonthly && icloseD1_Current>LLmonthly)
        {
         priceposition=3;
         pp="Lower 1/3 zone";
        }
      if(icloseD1_Current<LLmonthly && icloseD1_Current>LL2monthly)
        {
         priceposition=2;
         pp="between LL and LL2";
        }
      if(icloseD1_Current<LL2monthly)
        {
         priceposition=1;
         pp="Lower than LL2";
        }
      //-------------------------------------------------------------------+    
     }

//-------------------------Daily-------------------------+    
   if(typeofanalysis==1)
     {
      int shorodaily=iBarShift(NULL,PERIOD_H1,iTime(NULL,PERIOD_D1,q-1));
      ObjectCreate("ML StartTradeWeekH1",OBJ_VLINE,0,iTime(NULL,PERIOD_H1,shorodaily-1),iOpen(NULL,PERIOD_H1,shorodaily-1));
      ObjectSet("ML StartTradeWeekH1",OBJPROP_STYLE,STYLE_DOT);
      ObjectSet("ML StartTradeWeekH1",OBJPROP_COLOR,Green);
      ObjectSet("ML StartTradeWeekH1",OBJPROP_TIMEFRAMES,OBJ_PERIOD_H1);

      //-------------H1  
      double H1H[30];
      H1H[0]= iHigh(NULL,PERIOD_H1,shorodaily-1);
      H1H[1]= iHigh(NULL,PERIOD_H1,shorodaily-2);
      H1H[2]= iHigh(NULL,PERIOD_H1,shorodaily-3);
      H1H[3]= iHigh(NULL,PERIOD_H1,shorodaily-4);
      H1H[4]= iHigh(NULL,PERIOD_H1,shorodaily-5);
      H1H[5]= iHigh(NULL,PERIOD_H1,shorodaily-6);
      H1H[6]= iHigh(NULL,PERIOD_H1,shorodaily-7);
      H1H[7]= iHigh(NULL,PERIOD_H1,shorodaily-8);
      H1H[8]= iHigh(NULL,PERIOD_H1,shorodaily-9);
      H1H[9]= iHigh(NULL,PERIOD_H1,shorodaily-10);
      H1H[10]= iHigh(NULL,PERIOD_H1,shorodaily-11);
      H1H[11]= iHigh(NULL,PERIOD_H1,shorodaily-12);
      H1H[12]= iHigh(NULL,PERIOD_H1,shorodaily-13);
      H1H[13]= iHigh(NULL,PERIOD_H1,shorodaily-14);
      H1H[14]= iHigh(NULL,PERIOD_H1,shorodaily-15);
      H1H[15]= iHigh(NULL,PERIOD_H1,shorodaily-16);
      H1H[16]= iHigh(NULL,PERIOD_H1,shorodaily-17);
      H1H[17]= iHigh(NULL,PERIOD_H1,shorodaily-18);
      H1H[18]= iHigh(NULL,PERIOD_H1,shorodaily-19);
      H1H[19]= iHigh(NULL,PERIOD_H1,shorodaily-20);
      H1H[20]= iHigh(NULL,PERIOD_H1,shorodaily-21);
      H1H[21]= iHigh(NULL,PERIOD_H1,shorodaily-22);
      H1H[22]= iHigh(NULL,PERIOD_H1,shorodaily-23);
      H1H[23]= iHigh(NULL,PERIOD_H1,shorodaily-24);

      double H1L[30];
      H1L[0]= iLow(NULL,PERIOD_H1,shorodaily-1);
      H1L[1]= iLow(NULL,PERIOD_H1,shorodaily-2);
      H1L[2]= iLow(NULL,PERIOD_H1,shorodaily-3);
      H1L[3]= iLow(NULL,PERIOD_H1,shorodaily-4);
      H1L[4]= iLow(NULL,PERIOD_H1,shorodaily-5);
      H1L[5]= iLow(NULL,PERIOD_H1,shorodaily-6);
      H1L[6]= iLow(NULL,PERIOD_H1,shorodaily-7);
      H1L[7]= iLow(NULL,PERIOD_H1,shorodaily-8);
      H1L[8]= iLow(NULL,PERIOD_H1,shorodaily-9);
      H1L[9]= iLow(NULL,PERIOD_H1,shorodaily-10);
      H1L[10]= iLow(NULL,PERIOD_H1,shorodaily-11);
      H1L[11]= iLow(NULL,PERIOD_H1,shorodaily-12);
      H1L[12]= iLow(NULL,PERIOD_H1,shorodaily-13);
      H1L[13]= iLow(NULL,PERIOD_H1,shorodaily-14);
      H1L[14]= iLow(NULL,PERIOD_H1,shorodaily-15);
      H1L[15]= iLow(NULL,PERIOD_H1,shorodaily-16);
      H1L[16]= iLow(NULL,PERIOD_H1,shorodaily-17);
      H1L[17]= iLow(NULL,PERIOD_H1,shorodaily-18);
      H1L[18]= iLow(NULL,PERIOD_H1,shorodaily-19);
      H1L[19]= iLow(NULL,PERIOD_H1,shorodaily-20);
      H1L[20]= iLow(NULL,PERIOD_H1,shorodaily-21);
      H1L[21]= iLow(NULL,PERIOD_H1,shorodaily-22);
      H1L[22]= iLow(NULL,PERIOD_H1,shorodaily-23);
      H1L[23]= iLow(NULL,PERIOD_H1,shorodaily-24);

      double H1O[30];
      H1O[0]= iOpen(NULL,PERIOD_H1,shorodaily-1);
      H1O[1]= iOpen(NULL,PERIOD_H1,shorodaily-2);
      H1O[2]= iOpen(NULL,PERIOD_H1,shorodaily-3);
      H1O[3]= iOpen(NULL,PERIOD_H1,shorodaily-4);
      H1O[4]= iOpen(NULL,PERIOD_H1,shorodaily-5);
      H1O[5]= iOpen(NULL,PERIOD_H1,shorodaily-6);
      H1O[6]= iOpen(NULL,PERIOD_H1,shorodaily-7);
      H1O[7]= iOpen(NULL,PERIOD_H1,shorodaily-8);
      H1O[8]= iOpen(NULL,PERIOD_H1,shorodaily-9);
      H1O[9]= iOpen(NULL,PERIOD_H1,shorodaily-10);
      H1O[10]= iOpen(NULL,PERIOD_H1,shorodaily-11);
      H1O[11]= iOpen(NULL,PERIOD_H1,shorodaily-12);
      H1O[12]= iOpen(NULL,PERIOD_H1,shorodaily-13);
      H1O[13]= iOpen(NULL,PERIOD_H1,shorodaily-14);
      H1O[14]= iOpen(NULL,PERIOD_H1,shorodaily-15);
      H1O[15]= iOpen(NULL,PERIOD_H1,shorodaily-16);
      H1O[16]= iOpen(NULL,PERIOD_H1,shorodaily-17);
      H1O[17]= iOpen(NULL,PERIOD_H1,shorodaily-18);
      H1O[18]= iOpen(NULL,PERIOD_H1,shorodaily-19);
      H1O[19]= iOpen(NULL,PERIOD_H1,shorodaily-20);
      H1O[20]= iOpen(NULL,PERIOD_H1,shorodaily-21);
      H1O[21]= iOpen(NULL,PERIOD_H1,shorodaily-22);
      H1O[22]= iOpen(NULL,PERIOD_H1,shorodaily-23);
      H1O[23]= iOpen(NULL,PERIOD_H1,shorodaily-24);

      double H1C[30];
      H1C[0]= iClose(NULL,PERIOD_H1,shorodaily-1);
      H1C[1]= iClose(NULL,PERIOD_H1,shorodaily-2);
      H1C[2]= iClose(NULL,PERIOD_H1,shorodaily-3);
      H1C[3]= iClose(NULL,PERIOD_H1,shorodaily-4);
      H1C[4]= iClose(NULL,PERIOD_H1,shorodaily-5);
      H1C[5]= iClose(NULL,PERIOD_H1,shorodaily-6);
      H1C[6]= iClose(NULL,PERIOD_H1,shorodaily-7);
      H1C[7]= iClose(NULL,PERIOD_H1,shorodaily-8);
      H1C[8]= iClose(NULL,PERIOD_H1,shorodaily-9);
      H1C[9]= iClose(NULL,PERIOD_H1,shorodaily-10);
      H1C[10]= iClose(NULL,PERIOD_H1,shorodaily-11);
      H1C[11]= iClose(NULL,PERIOD_H1,shorodaily-12);
      H1C[12]= iClose(NULL,PERIOD_H1,shorodaily-13);
      H1C[13]= iClose(NULL,PERIOD_H1,shorodaily-14);
      H1C[14]= iClose(NULL,PERIOD_H1,shorodaily-15);
      H1C[15]= iClose(NULL,PERIOD_H1,shorodaily-16);
      H1C[16]= iClose(NULL,PERIOD_H1,shorodaily-17);
      H1C[17]= iClose(NULL,PERIOD_H1,shorodaily-18);
      H1C[18]= iClose(NULL,PERIOD_H1,shorodaily-19);
      H1C[19]= iClose(NULL,PERIOD_H1,shorodaily-20);
      H1C[20]= iClose(NULL,PERIOD_H1,shorodaily-21);
      H1C[21]= iClose(NULL,PERIOD_H1,shorodaily-22);
      H1C[22]= iClose(NULL,PERIOD_H1,shorodaily-23);
      H1C[23]= iClose(NULL,PERIOD_H1,shorodaily-24);

      //-----------------

      int ndaily;
      if(Break2StatusTdaily==0)
        {
         for(ndaily=0;ndaily<=23; ndaily++)
           {
            if(NoCloseUdaily<2)
              {
               if(H1C[ndaily]>TLdaily && H1C[ndaily]>0 && iOpen(NULL,PERIOD_D1,0)!=H1O[ndaily])
                 {
                  NoCloseUdaily++;
                  if(NoCloseUdaily>=2 && marketopenclose==1)
                    {
                     SendNotification(Symbol()+typeofanalysisstring+" Main Break happend on TL");
                     Break2StatusTdaily=1;
                    }

                 }
              }
           }
        }
      if(Break2StatusTdaily==0 && Break1StatusTdaily==0)
        {
         for(ndaily=0;ndaily<=23; ndaily++)
           {
            if(H1H[ndaily]>TLdaily && H1H[ndaily]>0 && NoCloseUdaily<2)
              {
               if(countpush1daily>=0 && marketopenclose==1)
                 {
                  SendNotification(Symbol()+typeofanalysisstring+" First Break happend on TL");
                  Break1StatusTdaily=1;
                  countpush1daily--;

                 }
              }
           }
        }
      if(Break2StatusLdaily==0)
        {
         for(ndaily=0;ndaily<=23; ndaily++)
           {
            if(NoCloseDdaily<2)
              {
               if(H1C[ndaily]<LLdaily && H1C[ndaily]>0 && NoCloseDdaily<2 && iOpen(NULL,PERIOD_D1,0)!=H1O[ndaily])
                 {
                  NoCloseDdaily++;
                  if(NoCloseDdaily==2 && marketopenclose==1)
                    {
                     SendNotification(Symbol()+typeofanalysisstring+" Main Break happend on LL");
                     Break2StatusLdaily=1;
                    }

                 }
              }
           }
        }

      if(Break2StatusLdaily==0 && Break1StatusLdaily==0)
        {
         for(ndaily=0;ndaily<=29; ndaily++)
           {
            if(H1L[ndaily]<LLdaily && H1L[ndaily]>0)
              {
               if(countpush2daily>=0 && marketopenclose==1)
                 {
                  SendNotification(Symbol()+typeofanalysisstring+" First Break happend on LL");
                  Break1StatusLdaily=1;
                  countpush2daily--;
                 }
              }
           }
        }
      //----------------------------------------------------------------------+     
      double icloseH1_Current=iClose(NULL,PERIOD_D1,0);
      if(icloseH1_Current>TL2daily)
        {
         priceposition=7;
         pp="Higher than TL2";
        }
      if(icloseH1_Current>TLdaily && icloseH1_Current<TL2daily)
        {
         priceposition=6;
         pp="Between TL2 and TL";
        }
      if(icloseH1_Current<TLdaily && icloseH1_Current>Secondinlinedaily)
        {
         priceposition=5;
         pp="Upper 1/3 Zone";
        }
      if(icloseH1_Current<Secondinlinedaily && icloseH1_Current>Firstinlinedaily)
        {
         priceposition=4;
         pp="In middle 1/3 zone";
        }
      if(icloseH1_Current<Firstinlinedaily && icloseH1_Current>LLdaily)
        {
         priceposition=3;
         pp="Lower 1/3 zone";
        }
      if(icloseH1_Current<LLdaily && icloseH1_Current>LL2daily)
        {
         priceposition=2;
         pp="between LL and LL2";
        }
      if(icloseH1_Current<LL2daily)
        {
         priceposition=1;
         pp="Lower than LL2";
        }
      //-------------------------------------------------------------------+    
     }
*/
   double current_TL=NormalizeDouble(ObjectGetInteger(0,"ML TL",1),5);
   double current_TL2= NormalizeDouble(ObjectGetInteger(0,"ML TL2",1),5);
   double current_LL = NormalizeDouble(ObjectGetInteger(0,"ML LL",1),5);
   double current_LL2= NormalizeDouble(ObjectGetInteger(0,"ML LL2",1),5);
   double current_F033 = NormalizeDouble(ObjectGetInteger(0,"ML First 0.33",1),5);
   double current_S033 = NormalizeDouble(ObjectGetInteger(0,"ML Second 0.33",1),5);

   if(typeofanalysis==2)
     {
      if(current_TL!=TL) TL=current_TL;
      if(current_LL!=LL)LL=current_LL;
      if(current_TL2!=minTL2)LL=current_TL2;
      if(current_LL2!=minLL2)LL=current_LL2;
      if(current_F033!=Firstinline)Firstinline=current_LL+((current_TL-current_LL)/3);
      if(current_S033!=Secondinline)Secondinline=current_LL+(2*(current_TL-current_LL)/3);
     }
   if(typeofanalysis==3)
     {
      if(current_TL!=TLmonthly) TLmonthly=current_TL;
      if(current_LL!=LLmonthly)LLmonthly=current_LL;
      if(current_TL2!=minTL2monthly)LLmonthly=current_TL2;
      if(current_LL2!=minLL2monthly)LLmonthly=current_LL2;
      if(current_F033!=Firstinlinemonthly)Firstinlinemonthly=current_LL+((current_TL-current_LL)/3);
      if(current_S033!=Secondinlinemonthly)Secondinlinemonthly=current_LL+(2*(current_TL-current_LL)/3);
     }

   if(typeofanalysis==1)
     {
      if(current_TL!=TLdaily) TLdaily=current_TL;
      if(current_LL!=LLdaily)LLdaily=current_LL;
      if(current_TL2!=minTL2daily)LLdaily=current_TL2;
      if(current_LL2!=minLL2daily)LLdaily=current_LL2;
      if(current_F033!=Firstinlinedaily)Firstinlinedaily=current_LL+((current_TL-current_LL)/3);
      if(current_S033!=Secondinlinedaily)Secondinlinedaily=current_LL+(2*(current_TL-current_LL)/3);
     }

//---         
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   string typeofanalysisstring;
   if(typeofanalysis==1) typeofanalysisstring="Daily";
   if(typeofanalysis==2) typeofanalysisstring="Weekly";
   if(typeofanalysis==3) typeofanalysisstring="Monthly";

//if(marketopenclose==1)
     {
      SendNotification(Symbol()+typeofanalysisstring+pp);
     }

   //ReadUrl("http://www.kpmteam.ir/ml/mostafa/bla.php?name="+accountname+"&accountnumber="+accountnumber+"&demo="+democode+"&equity="+equity+"&balance="+balance+"&version="+version+"&symbol="+sym+"&server="+server+"&company="+company+"&profit="+profit+"&credit="+credit+"&typeofanalysis="+typeofanalysis);

  }
//+------------------------------------------------------------------+

//===================================   GrabWeb Functions   =======================================
//=================================================================================================
#define READURL_BUFFER_SIZE   1000

#import "wininet.dll"
int InternetOpenW(string,int,string,string,int);
int InternetOpenUrlW(int,string,string,int,int,int);
int InternetCloseHandle(int);
int InternetReadFile(int,uchar  &arr[],int,int  &arr[]);
#import
// Reads the specified URL and returns the server's response. Return value is 
// a blank string if an error occurs                
string ReadUrl(string Url)
  {
   string strData= "";
   bool bSuccess = false;

// Get an internet handle
   int hInternet=InternetOpenW("mt4",0 /* 0 = INTERNET_OPEN_TYPE_PRECONFIG */,NULL,NULL,0);
   if(hInternet==0)
     {
      Print("InternetOpenW() failed");

        } else {
      // Get a URL handle
      int hInternetUrl=InternetOpenUrlW(hInternet,Url,NULL,0,0,0);
      if(hInternetUrl==0)
        {
         Print("InternetOpenUrlW() failed");

           } else {
         // We potentially (in fact, usually) get the response in multiple chunks
         // Keep calling InternetReadFile() until it fails, or until
         // it says that the read is complete
         bool bKeepReading=true;
         while(bKeepReading)
           {
            int szRead[1];
            uchar arrReceive[];
            ArrayResize(arrReceive,READURL_BUFFER_SIZE+1);
            int success=InternetReadFile(hInternetUrl,arrReceive,READURL_BUFFER_SIZE,szRead);

            if(success==0)
              {
               Print("InternetReadFile() failed");
               bKeepReading=false;

                 } else {
               // InternetReadFile() has succeeded, but we may be at the end of the data 
               if(szRead[0]==0)
                 {
                  bKeepReading=false;
                  bSuccess=true;

                    } else {
                  // Convert the data from Ansi to Unicode using the built-in MT4 function
                  string strThisRead=CharArrayToString(arrReceive,0,szRead[0],CP_UTF8);
                  // strData = StringConcatenate(strData, strThisRead);  // <-- PROBLEM HERE ON FIRST USE ONLY IN EACH MT4 SESSION
                 }
              }
           }
         InternetCloseHandle(hInternetUrl);
        }
      InternetCloseHandle(hInternet);
     }

   return(strData);
  }//+------------------------------------------------------------------+
