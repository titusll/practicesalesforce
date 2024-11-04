import { LightningElement, track, api } from 'lwc';
import updateSongWithAlbum from '@salesforce/apex/SongHandler.updateSongWithAlbum';
import getSongName from '@salesforce/apex/SongHandler.getSongName';

export default class songButton extends LightningElement {

    // Gets recordId when button is clicked on page layout
    @api recordId;
    @track message;
    @track errorMessage;

// Calls the apex methods to get the song name when button is clicked on page, calls fetch method to get album title from song name
async handleSongButtonClick (){

    try {

        // Get song name from record ID
        const songTitle = await getSongName(this.recordId);
        console.log("SONG NAME: " + songTitle);
        
        // Get album name from song
        const albumTitle = this.fetchAlbumTitle(songTitle);
        console.log("ALBUM TITLE: " + albumTitle);

        // Update the Album Title field on the song record
        const updateSongRecord = await updateSongWithAlbum(recordId, albumTitle);
        console.log("ALBUM TITLE ON RECORD: " + updateSongRecord);

    } catch {
        // Print any errors
        console.log("Error: " + this.errorMessage);
    }
}

// Calls some public music db to get the album title from some song input
async fetchAlbumTitle (songName) {

    const testUpdate = songName + "WORKS";

    return testUpdate;
}

}
