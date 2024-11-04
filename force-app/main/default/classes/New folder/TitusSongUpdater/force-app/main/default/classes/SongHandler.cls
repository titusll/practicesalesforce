public with sharing class SongHandler {

    public SongHandler(){
    
    }
    
        @AuraEnabled(cacheable=true)
        public static String updateSongWithAlbum (Id recordtoUpdate, String albumTitle) {
    
            Song__c currentSong = [SELECT Id, Name, Album__c FROM Song__c WHERE Id = :recordtoUpdate LIMIT 1];
    
            currentSong.Album__c = albumTitle;
    
            update currentSong;
    
            return 'Album Title: ' + currentSong.Album__c;
        }
    
        @AuraEnabled(cacheable=true)
        public static void getSongName(Id songRecordName) {
            System.debug('IN METHOD: ' + songRecordName);
            
            // Check if the input ID is valid
            if (songRecordName == null) {
                throw new AuraHandledException('Record ID cannot be null');
            }
        
            // Query the song record
            List<Song__c> songs = [SELECT Name, About__c FROM Song__c WHERE Id = :songRecordName LIMIT 1];
        
            // Check if a song was found
            if (songs.isEmpty()) {
                throw new AuraHandledException('No song found with the given ID');
            }
        
            Song__c song = songs[0];
        
            // Update the About field
            try {
                song.About__c = 'Listen Up';
                update song;
            } catch (Exception e) {
                System.debug('Error updating About field: ' + e.getMessage());
                throw new AuraHandledException('Error updating song record: ' + e.getMessage());
            }
        
            System.debug('FOUND SONG: ' + song.Name);
        }

        @AuraEnabled(cacheable=true)
        public static void updateSongAbout(Id songId, String newAboutVal){

            Song__c songToUpdate = new Song__c (Id = songId, About__c = newAboutVal);

            try {
                update songToUpdate; 
            } catch (Exception e) {
                System.debug('Error updating About field: ' + e.getMessage());
                throw new AuraHandledException('Error updating song record: ' + e.getMessage());
            }
        }


        
    }