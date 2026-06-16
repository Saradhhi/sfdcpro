import { LightningElement, track } from 'lwc';

export default class NoteTakingApp extends LightningElement {
    @track noteTitle = '';
    @track noteDescription = '';
    @track notesList = [];

    handleInputChange(event) {
        const { name, value } = event.target;
        this[name] = value;
    }

    get isInvalidNote() {
        return !this.noteTitle.trim() || !this.noteDescription.trim();
    }

    get hasNotes() {
        return this.notesList.length > 0;
    }

    handleAddNote() {
        if (this.isInvalidNote) return;

        const newNote = {
            id: Date.now().toString(),
            title: this.noteTitle,
            description: this.noteDescription,
            timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        };

        // Prepend note to keep newest on top
        this.notesList = [newNote, ...this.notesList];

        // Reset input fields
        this.noteTitle = '';
        this.noteDescription = '';
    }

    handleDeleteNote(event) {
        const noteIdToDelete = event.target.dataset.id;
        this.notesList = this.notesList.filter(note => note.id !== noteIdToDelete);
    }
}
