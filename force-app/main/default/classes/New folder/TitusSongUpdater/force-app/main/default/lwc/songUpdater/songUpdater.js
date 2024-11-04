import { LightningElement, track, api, wire } from 'lwc';
import updateSongAbout from '@salesforce/apex/SongHandler.updateSongAbout';

export default class songUpdater extends LightningElement {

    // Gets recordId when button is clicked on page layout
    @api recordId;
    @track message;
    @track errorMessage;

// Calls the apex methods to get the song name when button is clicked on page, calls fetch method to get album title from song name
    handleButtonClick (){

    console.log("BUTTON CLICKED");
    console.log("Record ID: ", this.recordId);

    try {

        // Get song name from record ID
      //  const songTitleResponse = await getSongName('a00dL00000Ox2xdQAB');
     //   console.log("SONG NAME: " + songTitleResponse);
    updateSongAbout (this.recordId,'WORKING'); // Use await and pass the record ID as an object
     console.log("Song record updated successfully.");

     /**  
        // Get album name from song
        const albumTitle = await this.fetchAlbumTitle(songTitle);
        console.log("ALBUM TITLE: " + albumTitle);

        // Update the Album Title field on the song record
        const updateSongRecord = await updateSongWithAlbum(this.recordId, albumTitle);
        console.log("ALBUM TITLE ON RECORD: " + updateSongRecord);

        */

    } catch (error) {
        // Print any errors
        console.error("Error: ", error);
        this.errorMessage = error.body ? error.body.message : error.message;
    }
}

// Calls some public music db to get the album title from some song input
  fetchAlbumTitle (songName) {

    const testUpdate = songName + "WORKS";

    return testUpdate;
}

}