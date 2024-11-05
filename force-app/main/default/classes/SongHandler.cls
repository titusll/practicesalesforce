@RestResource(urlMapping='/Songs/*')
global with sharing class SongHandler {

    public SongHandler(){
    
    }
    
        @AuraEnabled
        public static String updateSongWithAlbum (Id recordtoUpdate, String albumTitle) {
    
            Song__c currentSong = [SELECT Id, Name, Album__c FROM Song__c WHERE Id = :recordtoUpdate LIMIT 1];
    
            currentSong.Album__c = albumTitle;
    
            update currentSong;
    
            return 'Album Title: ' + currentSong.Album__c;

            System.debug('HELLO');
        }
    
        @AuraEnabled(cacheable=true)
        public static String getSongName(Id songRecordName) {

            System.debug('INSIDE GETSONGNAME' + songRecordName);
    
            Song__c song = [SELECT Name FROM Song__c WHERE Id = :songRecordName LIMIT 1];

            System.debug('FOUND SONG' + song.Name);

            song.About__c = 'This is a TEST, it works';

            update song;
    
            return song.Name;
        }

        @AuraEnabled(cacheable=true)
        public static string fetchAboutFromSong(Id songId){
            try {
                Song__c s = [SELECT Name, About FROM Song__c WHERE Id = :songId LIMIT 1];
                System.debug('SONG FOUND: ' + s.Name);
                return s.About__c;
                
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        @HttpGet
        global static Song__c sendStuff(){
            Request req = RestContext.request;

            String songId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

            Song__c sendThis = [SELECT Name, Artist__c FROM Song WHERE Id = :songId];

            return sendThis;
        }
    }