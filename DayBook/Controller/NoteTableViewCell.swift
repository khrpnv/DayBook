//
//  NoteTableViewCell.swift
//  DayBook
//
//  Created by Илья on 6/12/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentPreviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(note: Note){
        titleLabel.text = note.title
        contentPreviewLabel.text = NotesManager.instance.getNotePreview(content: note.content)
    }

}
