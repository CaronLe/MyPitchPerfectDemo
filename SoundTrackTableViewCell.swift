//
//  SoundTrackTableViewCell.swift
//  PitchPerfect
//
//  Created by Swift on 02/02/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class SoundTrackTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var nameSoundTrack: UILabel!
    @IBOutlet weak var typeofSoundTrack: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
