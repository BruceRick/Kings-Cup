//
//  RulesAndPlayers.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-06-28.
//
//

#import "RulesAndPlayers.h"

#define N_OF_SECTION    52
#define N_OF_ROW        1
#define CellIndexLabel  1
#define RulesNameLabel  2

@implementation RulesAndPlayers
{
    
    UITableView *table;
    int count[N_OF_SECTION];
    CGSize winSize;
    
}

@synthesize m_pData;
@synthesize m_pPlayers;
@synthesize m_pRules;
@synthesize m_pMenu;
static RulesAndPlayers* Instance = nil;

-(id)init
{
    if ((self = [super init]))
    {
        
        [self Read];
        winSize = [CCDirector sharedDirector].winSize;
        
        CCLabelBMFont *back = [CCLabelBMFont labelWithString:@"Back" fntFile:@"KingsCupBitMapFont-empty.fnt"];
        CCMenuItemLabel *backButton = [CCMenuItemLabel itemWithLabel:back target:self selector:@selector(backButtonTapped:)];
        [CCMenuItemFont setFontSize:32];
        [CCMenuItemFont setFontName:@"KingsCupBitMapFont-empty"];
        m_pMenu = [CCMenu menuWithItems:backButton, nil];
        m_pMenu.position = ccp(winSize.width/2, winSize.height/10);
        [m_pMenu alignItemsVertically];
        [m_pMenu alignItemsVerticallyWithPadding:10];

        
    }
    
    return self;
}

+(RulesAndPlayers*)Instance
{
    @synchronized([RulesAndPlayers class])
    {
        if (!Instance)
            [[self alloc] init];
        
        return Instance;
    }
    return nil; 
}

+(id)alloc
{
    @synchronized([RulesAndPlayers class])
    {
        NSAssert(Instance == nil, @"Attempted to allocate a second instance of a singleton.");
        Instance = [super alloc];
        return Instance;
    }
    return nil;
}

-(void)Read
{
    
    m_pData = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"RulesAndPlayers"ofType:@"plist"]];
    m_pRules = [[NSMutableArray alloc] initWithArray:[m_pData valueForKey:@"Rules"]];
    m_pPlayers = [[NSMutableArray alloc] initWithArray:[m_pData valueForKey:@"Players"]];
    
}

-(void)Write
{
    
    
    
    UITableViewCell *cell;
    UITextField *cellindexLabel;
    //NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (NSInteger j = 0; j < [table numberOfSections]; ++j)
    {
        for (NSInteger i = 0; i < [table numberOfRowsInSection:j]; ++i)
        {
            cell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
            cellindexLabel = (UITextField *)[cell.contentView viewWithTag:RulesNameLabel];
            if(cell != nil && cellindexLabel != nil)
                [m_pRules setObject:cellindexLabel.text atIndexedSubscript:j];
            
        }
    }
    
    [[NSMutableDictionary dictionaryWithDictionary:m_pData] setValue:m_pRules forKeyPath:@"Rules"];
    [m_pData writeToFile:@"RulesAndPlayer.plist" atomically:YES];

    [cell release];
    [cellindexLabel release];
    
}

-(void)ShowTable
{
    
    for (int i = 0; i < N_OF_SECTION; i++)
    {
        count[i] = N_OF_ROW;
    }
    
    CGRect frame = CGRectMake(0, 0, winSize.width, winSize.height - winSize.height/8);
    table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    table.layer.cornerRadius = 5;
    table.layer.borderColor = [UIColor blackColor].CGColor;
    table.layer.borderWidth = 2;
    table.backgroundColor = [UIColor blackColor];
    table.separatorColor = [UIColor blackColor];
    table.rowHeight = 70;
    table.allowsSelection = YES;     // cell can't select
    table.alpha = 0;
    table.dataSource = self;
    table.delegate = self;
    [[[CCDirector sharedDirector] view] addSubview:table];
    
    [UIView animateWithDuration:0.1 animations:^(void){
        table.alpha = 1.0;
    }];
    
    
    
}

-(void)RemoveTable
{
    [table removeFromSuperview];
    table = nil;
    [table release];
    
}

-(void)backButtonTapped:(id)sender
{
    
    [self Write];
    [self RemoveTable];
    [m_pMenu removeFromParentAndCleanup:NO];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellCustom";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITextField *cellindexLabel;
    UITextField *ruleNameLabel;
    
    if (cell == nil)
    {
                
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        CGPoint cellIndexLabelSize = ccp(table.bounds.size.width/6,table.rowHeight/3);
        
        cellindexLabel = [ [UITextField alloc ] initWithFrame:CGRectMake(cellIndexLabelSize.x/2, table.rowHeight/2 - cellIndexLabelSize.y/2, cellIndexLabelSize.x,cellIndexLabelSize.y)];
        cellindexLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        cellindexLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        cellindexLabel.textColor = [UIColor blackColor];
        cellindexLabel.font = [UIFont fontWithName:@"KingsCupBitMapFont-empty.fnt" size:(cellIndexLabelSize.y)];
        cellindexLabel.tag = CellIndexLabel;
        [cellindexLabel setUserInteractionEnabled:NO];
        
        CGPoint ruleLabelSize = ccp(table.bounds.size.width - (cellIndexLabelSize.x*1.5),table.rowHeight/3);
        
        ruleNameLabel = [[UITextField alloc] initWithFrame:CGRectMake(cellIndexLabelSize.x*1.5, table.rowHeight/2- ruleLabelSize.y/2,ruleLabelSize.x, ruleLabelSize.y)];
        
        ruleNameLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        ruleNameLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        ruleNameLabel.textColor = [UIColor blackColor];
        ruleNameLabel.font = [UIFont fontWithName:@"KingsCupBitMapFont-empty.fnt" size:(cellIndexLabelSize.y)];
        ruleNameLabel.tag = RulesNameLabel;
        ruleNameLabel.delegate = self;
        //[ruleNameLabel setUserInteractionEnabled:NO];
    
        [cell.contentView addSubview:ruleNameLabel];
        [cell.contentView addSubview:cellindexLabel];
        //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else
    {
        
        cellindexLabel = (UITextField *)[cell.contentView viewWithTag:CellIndexLabel];
        ruleNameLabel = (UITextField *)[cell.contentView viewWithTag:RulesNameLabel];
        
    }
    
    NSMutableString *index = [[NSMutableString alloc] initWithString:@""];
    [index appendString:[NSString stringWithFormat:@"%d",indexPath.section + 1]];
    cellindexLabel.text = [self GetCardValue:indexPath.section+1];
    [index release];
    
    ruleNameLabel.text = [m_pRules objectAtIndex:indexPath.section];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return N_OF_SECTION;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return count[section];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    count[indexPath.section]--;
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    
    
    [textField resignFirstResponder];
    return YES;
}

-(NSMutableString *)GetCardValue:(int) a_RuleNumber
{
    
    NSMutableString *CardValue = [[NSMutableString alloc] initWithString:@""];
    int Suit = a_RuleNumber/14;
    int Value = a_RuleNumber%13;    
    
    switch (Suit)
    {
        case 0:
            [CardValue appendString:@"♥"];
            break;
        case 1:
            [CardValue appendString:@"♦"];
            break;
        case 2:
            [CardValue appendString:@"♠"];
            break;
        case 3:
            [CardValue appendString:@"♣"];
            break;
        default:
            break;
    }
    
    switch (Value) {
        case 1:
            [CardValue appendString:@"A"];
            break;
        case 11:
            [CardValue appendString:@"J"];
            break;
        case 12:
            [CardValue appendString:@"Q"];
            break;
        case 0:
            [CardValue appendString:@"K"];
            break;
        default:
            [CardValue appendString:[NSString stringWithFormat:@"%d", Value]];
            break;
    }
    
    return CardValue;
}

@end
