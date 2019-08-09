package view.image.tutorial
{

    import flash.display.*;
    import flash.events.Event;

    import org.libspark.thread.*;
    import org.libspark.thread.utils.*;
    import org.libspark.thread.threads.between.BeTweenAS3Thread;


    import flash.events.MouseEvent;

    import view.image.BaseLoadImage;
    import controller.TitleCtrl;

    /**
     * TutorialMovie表示クラス
     *
     */


    public class TutorialMovie extends BaseLoadImage
    {

        // インスタンス名
        private static const FACE:String = "face"

        private static const URL:String = "/public/image/tutorial/";

        CONFIG::LOCALE_JP
        private static const NAME_SET:Vector.<String> = Vector.<String>([
                                                                            "tut_start.swf",
                                                                            "tut_startquest.swf",
                                                                            "tut_startbtl.swf",
                                                                            "tut_startfinish.swf",

                                                                            "tut_battle.swf",
                                                                            "tut_change.swf",
                                                                            "tut_bonus.swf",
                                                                            "tut_event.swf",

                                                                            "tut_entrance.swf",
                                                                            "tut_quest.swf",
                                                                            "tut_deck.swf",
                                                                            "tut_duel.swf",
                                                                            "tut_item.swf",
                                                                            "tut_shop.swf",
                                                                            "tut_comp.swf"]);
        CONFIG::LOCALE_TCN
        private static const NAME_SET:Vector.<String> = Vector.<String>([
                                                                    "tut_start_ch.swf",
                                                                    "tut_startquest_ch.swf",
                                                                    "tut_startbtl_ch.swf",
                                                                    "tut_startfinish_ch.swf",

                                                                    "tut_battle_ch.swf",
                                                                    "tut_change_ch.swf",
                                                                    "tut_bonus_ch.swf",
                                                                    "tut_event_ch.swf",

                                                                    "tut_entrance_ch.swf",
                                                                    "tut_quest_ch.swf",
                                                                    "tut_deck_ch.swf",
                                                                    "tut_duel_ch.swf",
                                                                    "tut_item_ch.swf",
                                                                    "tut_shop_ch.swf",
                                                                    "tut_comp_ch.swf"]);

        private static const GAME:String = "game";
        private static const NEXT:String = "next";
        private static const EXIT:String = "exit";

        public static const PUSH_GAME_BUTTON:String = "push_game_button"
        public static const PUSH_NEXT_BUTTON:String = "push_next_button"
        public static const PUSH_EXIT_BUTTON:String = "push_exit_button"

        private var _gameButton:SimpleButton;
        private var _nextButton:SimpleButton;
        private var _exitButton:SimpleButton;

        public static const TYPE_START         :int =0;
        public static const TYPE_START_QUEST   :int =1;
        public static const TYPE_START_BATTLE  :int =2;
        public static const TYPE_START_END     :int =3;

        public static const TYPE_BATTLE        :int =4;
        public static const TYPE_CHANGE        :int =5;
        public static const TYPE_HILOW         :int =6;
        public static const TYPE_EVENT         :int =7;

        public static const TYPE_ENTRANCE      :int =8;
        public static const TYPE_QUEST         :int =9;
        public static const TYPE_DECK          :int =10;
        public static const TYPE_DUEL          :int =11;
        public static const TYPE_ITEM          :int =12;
        public static const TYPE_SHOP          :int =13;
        public static const TYPE_COMPO         :int =14;

        public static const LABEL_START:String        = "start";
        public static const LABEL_FINISH:String       = "finish";
        public static const LABEL_OUTLINE:String      = "outline";
        public static const LABEL_CYCLE:String        = "cycle";
        public static const LABEL_ENT:String          = "ent";

        public static const LABEL_BONUS:String        = "bonus";
        public static const LABEL_EVENT:String        = "event";

        public static const LABEL_QUEST_OUTLINE:String= "quest_outline";
        public static const LABEL_QUEST_SEARCH:String = "quest_search";
        public static const LABEL_QUEST_QUEST:String  = "quest_quest";
        public static const LABEL_DRW_ACT:String      = "drw_act";
        public static const LABEL_MOV:String          = "mov";
        public static const LABEL_ATK:String          = "atk";
        public static const LABEL_DEF:String          = "def";
        public static const LABEL_SKILL:String        = "skill";
        public static const LABEL_DECK_OUTLINE:String = "deck_outline";
        public static const LABEL_DECK_BINDER:String  = "deck_binder";
        public static const LABEL_DECK_DECK:String    = "deck_deck";
        public static const LABEL_DECK_CARD:String    = "deck_card";
        public static const LABEL_DECK_LV:String      = "deck_ｌｖ";

        public static const LABEL_DUEL:String         = "duel";
        public static const LABEL_CH:String           = "ch";
        public static const LABEL_ROOM:String         = "room";
        public static const LABEL_PRE_QUEST:String    = "pre_quest";
        public static const LABEL_PRE_CHG:String      = "pre_chg";
        public static const LABEL_CHANGE:String       = "change";
        public static const LABEL_ITEM_OUTLINE:String = "outline";
        public static const LABEL_SHOP_OUTLINE:String = "outline";
        public static const LABEL_ITEM_ITEM:String    = "item";
        public static const LABEL_SHOP_BUY:String     = "buy";
        public static const LABEL_COMPO:String        = "buy";


        private var _label:String;
        private var _type:int;

        /**
         * コンストラクタ
         *
         */
        public function TutorialMovie(type:int)
        {
            _type = type;
            visible = false;
            super(URL+NAME_SET[type]);
        }

        override protected function swfinit(event: Event): void
        {
            super.swfinit(event);
            _gameButton= SimpleButton(_root.getChildByName(GAME));
            _nextButton= SimpleButton(_root.getChildByName(NEXT));
            _exitButton = SimpleButton(_root.getChildByName(EXIT));
//              // とれない
//              log.writeLog(log.LV_FATAL, this, "button get?", _nextButton, _exitButton);
//              log.writeLog(log.LV_FATAL, this, "num children", _root.numChildren, _type);

             if(_gameButton)
             {
                 _gameButton.addEventListener(MouseEvent.CLICK, pushGameHandler);
             }
             if(_nextButton)
             {
                 _nextButton.addEventListener(MouseEvent.CLICK, pushNextHandler);
             }
             if(_exitButton)
             {
                 _exitButton.addEventListener(MouseEvent.CLICK, pushExitHandler);
             }
        }

        public override function init():void
        {
        }

        public override function final():void
        {
            _gameButton.removeEventListener(MouseEvent.CLICK, pushGameHandler);
            _nextButton.removeEventListener(MouseEvent.CLICK, pushNextHandler);
            _exitButton.removeEventListener(MouseEvent.CLICK, pushExitHandler);
        }


        // ラベルを再生
        public function playLabel(label:String):void
        {
            _label = label;
            waitComplete(startMovie);
        }
        private function startMovie():void
        {
            visible = true;
            _root.gotoAndPlay(_label);
        }

        // ラベルを再生
        public function playMovie():void
        {
            waitComplete(playMovieComplete);
        }
        private function playMovieComplete():void
        {
            _root.gotoAndPlay(1);
            TitleCtrl.instance.updateTutePlay(_type);
        }


        private function pushGameHandler(e:MouseEvent):void
        {
            log.writeLog(log.LV_INFO, this, "tutorial exit");
            dispatchEvent(new Event(PUSH_GAME_BUTTON));
        }
        private function pushExitHandler(e:MouseEvent):void
        {
            log.writeLog(log.LV_INFO, this, "tutorial exit");
            dispatchEvent(new Event(PUSH_EXIT_BUTTON));
        }
        private function pushNextHandler(e:MouseEvent):void
        {
            log.writeLog(log.LV_INFO, this, "tutorial next");
            dispatchEvent(new Event(PUSH_NEXT_BUTTON));
        }

    }
}
