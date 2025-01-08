import { LightningElement } from 'lwc';

export default class BlueBackgroundCard extends LightningElement {
    name = 'BOB';
    imageURL = 'https://via.placeholder.com/150';  // Default image URL

    connectedCallback() {
        // Retrieve the saved name from local storage on component load
        const savedName = localStorage.getItem('name');
        if (savedName) {
            this.name = savedName;
        }

        // Retrieve the saved image URL from local storage
        const savedImageURL = localStorage.getItem('imageURL');
        if (savedImageURL) {
            this.imageURL = savedImageURL;
        }
    }

    handleNameChange(event) {
        // Update the name property as the user edits it
        this.name = event.target.innerText;

        // Save the updated name to local storage
        localStorage.setItem('name', this.name);
    }

    handleImageURLChange(event) {
        // Update the image URL as the user edits it
        this.imageURL = event.target.value;
    }

    handleSave() {
        // Save the updated image URL to local storage
        localStorage.setItem('imageURL', this.imageURL);
    }

    handleCancel() {
        // Reset the image URL to the last saved value from local storage
        const savedImageURL = localStorage.getItem('imageURL');
        if (savedImageURL) {
            this.imageURL = savedImageURL;
        }
    }
}