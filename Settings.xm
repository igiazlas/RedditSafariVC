@interface BaseLabel : UILabel
@end

@interface AttributedLabelRegular : BaseLabel
@end

@interface RoundedImageView

@property(retain, nonatomic) UIImage *image;

@end

@interface ImageLabelContentView

@property(readonly, nonatomic) AttributedLabelRegular *mainLabel;
@property(readonly, nonatomic) RoundedImageView *imageView;

@end

@interface BaseTableViewCell : UITableViewCell

@property(retain, nonatomic) ImageLabelContentView *imageLabelView;

@end

@interface ImageLabelTableViewCell : BaseTableViewCell
@end

@interface ToggleImageTableViewCell : ImageLabelTableViewCell

@property(retain, nonatomic) UISwitch *accessorySwitch;

@end

@interface AccountSettingsViewController

- (UITableViewCell *)setupReaderModeCellForTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
- (void)didToggleSafariReaderMode:(UISwitch *)sender;

@end

%hook AccountSettingsViewController

NSInteger viewOptionsSectionRows = 0;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //: View Options Section
    if (section == 1) {
        viewOptionsSectionRows = %orig + 1;
        return viewOptionsSectionRows;
    } else {
        return %orig;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == viewOptionsSectionRows - 1) {
        return [self setupReaderModeCellForTableView:tableView andIndexPath:indexPath];
    }

    return %orig;
}

%new
- (UITableViewCell *)setupReaderModeCellForTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath {
    ToggleImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kToggleCellID" forIndexPath:indexPath];

    cell.imageLabelView.mainLabel.text = @"Reader Mode";

    UIImage *cellImage = [UIImage imageNamed:@"icon_safari"];
    cellImage = [cellImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.imageLabelView.imageView.image = cellImage;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL readerModeOn = [userDefaults boolForKey:@"safari_reader_mode"];
    [cell.accessorySwitch setOn:readerModeOn animated:NO];

    [cell.accessorySwitch addTarget:self action:@selector(didToggleSafariReaderMode:) forControlEvents:UIControlEventValueChanged];

    return cell;
}

%new
- (void)didToggleSafariReaderMode:(UISwitch *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setBool:sender.on forKey:@"safari_reader_mode"];
}

%end


