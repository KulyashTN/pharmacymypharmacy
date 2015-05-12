//
//  PPViewController.m
//  PPImageScrollingTableViewControllerDemo
//
//  Created by popochess on 13/8/9.
//  Copyright (c) 2013年 popochess. All rights reserved.
//

#import "PPViewController.h"
#import "PPImageScrollingTableViewCell.h"
#import "subViewcontroller.h"

@interface PPViewController()<PPImageScrollingTableViewCellDelegate>

@property (strong, nonatomic) NSArray *images;

@end

@implementation PPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Notes";
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    
    static NSString *CellIdentifier = @"Cell";
    [self.tableView registerClass:[PPImageScrollingTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.images = @[
                    @{ @"category": @"Признаки жизни: дыхание",
                       @"images":
                           @[
    @{ @"name":@"1.jpg", @"title":@"дыхание",@"texts":@"Алгоритм оказания первой помощи Чтобы не растеряться и грамотно оказать первую помощь, важно соблюдать следующую последовательность действий:Обеспечить безопасность себе, пострадавшему и окружающим (например, извлечь пострадавшего из горящего автомобиля).Проверить наличие у пострадавшего признаков жизни (пульс, дыхание, реакция зрачков на свет) и сознания. "},
                               @{ @"name":@"2.jpg", @"title":@"пульс",@"texts":@"Для проверки дыхания необходимо запрокинуть голову пострадавшего, наклониться к его рту и носу и попытаться услышать или почувствовать дыхание. для «прослушивания» пульса необходимо приложить подушечки пальцев к сонной артерии пострадавшего; для оценки сознания необходимо (по возможности) взять пострадавшего за плечи, аккуратно встряхнуть и задать какой-либо вопрос.Вызвать специалистов (112 – с мобильного телефона, с городского – 03 (скорая) или 01 (спасатели))."},
                               @{ @"name":@"3.jpg", @"title":@"реакция зрачков на свет",@"texts":@"Оказать неотложную первую помощь. В зависимости от ситуации это может быть:восстановление проходимости дыхательных путей.сердечно-легочная реанимация.остановка кровотечения и другие мероприятия.Обеспечить пострадавшему физический и психологический комфорт, дождаться прибытия специалистов."},
                            ]
                       },
                    @{ @"category": @"Признаки жизни: пульс",
                       @"images":
                           @[
    @{ @"name":@"4.jpg", @"title":@"Очистите верхние дыхательные пути",@"texts":@" Искусственное дыхание Искусственная вентиляция легких (ИВЛ) – это введение воздуха (либо кислорода) в дыхательные пути человека с целью восстановления естественной вентиляции легких. Относится к элементарным реанимационным мероприятиям."},
                               @{ @"name":@"5.jpg", @"title":@"Запрокиньте голову пострадавшего назад",@"texts":@" Искусственное дыхание Искусственная вентиляция легких (ИВЛ) – это введение воздуха (либо кислорода) в дыхательные пути человека с целью восстановления естественной вентиляции легких. Относится к элементарным реанимационным мероприятиям."},
    @{ @"name":@"6.jpg", @"title":@"Сделайте искусственное дыхание",@"texts":@" Типичные ситуации, требующие ИВЛ:автомобильная авария;происшествие на воде;удар током и другие."},
                            ]
                       },
                    @{ @"category": @"Признаки жизни: реакция зрачков на свет",
                       @"images":
                           @[
    @{ @"name":@"7.jpg", @"title":@"Мечевидный отросток",@"texts":@"Техника непрямого массажа сердца:Уложите пострадавшего на плоскую твердую поверхность. На кровати и других мягких поверхностях проводить компрессию грудной клетки нельзя."},
    @{ @"name":@"8.jpg", @"title":@"Найдите мечевидный отросток",@"texts":@"Определите расположение у пострадавшего мечевидного отростка. Мечевидный отросток – это самая короткая и узкая часть грудины, её окончание.Отмерьте 2-4 см вверх от мечевидного отростка – это точка компрессии."},
                               @{ @"name":@"9.jpg", @"title":@"Установите ладонь на точку компрессии",@"texts":@"Положите основание ладони на точку компрессии. При этом большой палец должен указывать либо на подбородок либо на живот пострадавшего, в зависимости от местоположения лица, осуществляющего реанимацию. Поверх одной руки положите вторую ладонь. "},
                               @{ @"name":@"10.jpg", @"title":@"Положение рук",@"texts":@"Надавливания проводятся строго основанием ладони – ваши пальцы не должны соприкасаться с грудиной пострадавшего."},
                               @{ @"name":@"11.jpg", @"title":@"Осуществляйте ритмичные толчки грудной клетки",@"texts":@"Осуществляйте ритмичные толчки грудной клетки сильно, плавно, строго вертикально, тяжестью верхней половины вашего тела. Частота – 100-110 надавливаний в минуту. При этом грудная клетка должна прогибаться на 3-4 см."},
                               @{ @"name":@"12.jpg", @"title":@"Непрямой массаж сердца младенцу, подростку, взрослому",@"texts":@"Грудным детям непрямой массаж сердца производится указательным и средним пальцем одной руки. Подросткам – ладонью одной руки."}
                            ]
                       },
                    @{ @"category": @"Алгоритм оказания первой помощи",
                       @"images":
                           @[
    @{ @"name":@"13.jpg", @"title":@"Обхватите пострадавшего сзади под реберной дугой",@"texts":@"Прием Геймлиха При попадании пищи или инородных тел в трахею, она закупоривается (полностью или частично) – человек задыхается."},
    @{ @"name":@"14.jpg", @"title":@"Сильно надавите на живот пострадавшего",@"texts":@"Признаки закупоривания дыхательных путей:Отсутствие полноценного дыхания. Если дыхательное горло закупорено не полностью, человек кашляет; если полностью – держится за горло.Неспособность говорить.Посинение кожи лица, набухание сосудов шеи.Очистку дыхательных путей чаще всего проводят по методу Геймлиха:"},
    @{ @"name":@"15.jpg", @"title":@"Если человек без сознания, сядьте ему на бедра и обеими руками надавите на реберные дуги",@"texts":@"Встаньте позади пострадавшего.Обхватите его руками, сцепив их в «замок», чуть выше пупка, под реберной дугой.Сильно надавите на живот пострадавшего, резко сгибая руки в локтях.Не сдавливайте грудь пострадавшего, за исключением беременных женщин, которым надавливания осуществляются в нижнем отделе грудной клетки.Повторите прием несколько раз, пока дыхательные пути не освободятся."},
                               ]
                       } ,
    @{ @"category": @"Типичные ситуации, требующие ИВЛ:",
    @"images":
    @[
    @{ @"name":@"17.jpg", @"title":@"Накладывайте жгут через одежду или мягкую подкладку",@"texts":@"КровотечениеОстановка кровотечения – это меры, направленные на остановку потери крови. При оказании первой помощи речь идет об остановке наружного кровотечения. В зависимости от типа сосуда, выделяют капиллярное, венозное и артериальное кровотечения."},
    @{ @"name":@"18.jpg", @"title":@"Затяните жгут",@"texts":@"Остановка капиллярного кровотечения осуществляется путем наложения асептической повязки, а также, если ранены руки или ноги, поднятием конечностей выше уровня туловища."},
    @{ @"name":@"19.jpg", @"title":@"Забинтуйте рану",@"texts":@"При венозном кровотечении накладывается давящая повязка. Для этого выполняется тампонада раны: на рану накладывается марля, поверх нее укладывается несколько слоев ваты (если нет – чистое полотенце), туго бинтуется. Сдавленные такой повязкой вены быстро тромбируются – кровотечение прекращается.Если давящая повязка промокает, сильно надавите на нее ладонью.Чтобы остановить артериальное кровотечение, артерию необходимо пережать."},
    
    ]
    },
    @{ @"category": @"Очистите верхние дыхательные пути",
    @"images":
    @[
    @{ @"name":@"16.jpg", @"title":@"Прием Геймлиха"},
    ]
    },
    @{ @"category": @"Техника непрямого массажа сердца:",
    @"images":
    @[
    @{ @"name":@"20.jpg", @"title":@"Наложение шины на предплечье",@"texts":@"Переломы.Перелом – нарушение целости кости. Перелом сопровождается сильной болью, иногда – обмороком или шоком, кровотечением. Различают открытые и закрытые переломы. Первый сопровождается ранением мягких тканей, в ране иногда заметны отломки кости."},
    @{ @"name":@"21.jpg", @"title":@"Наложение шины на голень",@"texts":@"Первая помощь при переломе:Оцените тяжесть состояния пострадавшего, определите локализацию перелома.При наличии кровотечения, остановите его.Определите, возможно ли перемещение пострадавшего до прибытия специалистов.Не переносите пострадавшего и не меняйте его положения при травмах позвоночника!Обеспечьте неподвижность кости в области перелома – иммобилизация. Для этого необходимо обездвижить суставы, расположенные выше и ниже перелома."},
    @{ @"name":@"22.jpg", @"title":@"Наложение шины при переломе бедра",@"texts":@"Наложите шину. В качестве шины можно использовать плоские палки, доски, линейки, прутья и прочее. Шину необходимо плотно, но не туго, зафиксировать бинтами или пластырем.При закрытом переломе иммобилизация производится поверх одежды; при открытом нельзя прикладывать шину к местам, где кость выступает наружу."},
    ]
    },
    @{ @"category": @"Прием Геймлиха",
    @"images":
    @[
    @{ @"name":@"23.jpg", @"title":@"C-0"},
    ]
    },
    @{ @"category": @"Category C",
    @"images":
    @[
    @{ @"name":@"24.jpg", @"title":@"C-0"},
    @{ @"name":@"25jpg", @"title":@"C-1"},
    @{ @"name":@"26.jpg", @"title":@"C-2"},

    ]
    }
                    ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.images count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *cellData = [self.images objectAtIndex:[indexPath section]];
    PPImageScrollingTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [customCell setBackgroundColor:[UIColor grayColor]];
    [customCell setDelegate:self];
    [customCell setImageData:cellData];
    [customCell setCategoryLabelText:[cellData objectForKey:@"category"] withColor:[UIColor whiteColor]];
    [customCell setTag:[indexPath section]];
    [customCell setImageTitleTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [customCell setImageTitleLabelWitdh:90 withHeight:45];
    [customCell setCollectionViewBackgroundColor:[UIColor darkGrayColor]];
 
    return customCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PPImageScrollingTableViewCellDelegate

- (void)scrollingTableViewCell:(PPImageScrollingTableViewCell *)scrollingTableViewCell didSelectImageAtIndexPath:(NSIndexPath*)indexPathOfImage atCategoryRowIndex:(NSInteger)categoryRowIndex
{

    NSDictionary *images = [self.images objectAtIndex:categoryRowIndex];
    NSArray *imageCollection = [images objectForKey:@"images"];
//    NSArray *currentArr = [imageCollection objectAtIndex:categoryRowIndex];
//    NSDictionary* currentImgColl = [currentArr objectAtIndex:categoryRowIndex];
//    NSString* currentIMAGE = [currentImgColl objectForKey:@"name"];
    
    NSString *imageTitle = [[imageCollection objectAtIndex:[indexPathOfImage row]]objectForKey:@"title"];
    NSString *categoryTitle = [[self.images objectAtIndex:categoryRowIndex] objectForKey:@"category"];
    NSString *IMAGE = [[imageCollection objectAtIndex:[indexPathOfImage row]]objectForKey:@"name"];
    NSString* texts = [[imageCollection objectAtIndex:[indexPathOfImage row]]objectForKey:@"texts"];
    
    subViewcontroller* subVC=[self.storyboard instantiateViewControllerWithIdentifier:@"subViewcontroller"];
    if(IMAGE){
        subVC.detailImage = IMAGE;
        subVC.detailText = texts;
    [self.navigationController pushViewController:subVC animated:YES];
    }
    //[self performSegueWithIdentifier:@"tosubview" sender:self];
    

    
}

//- (void) didSelectItemFromCollectionView:(NSNotification *)notification
//{
//    subViewcontroller* subVC=[self.storyboard instantiateViewControllerWithIdentifier:@"subViewcontroller"];
//    
//    NSDictionary *cellData = [notification object];
//    //NSArray* arrayWithColl=[notification object];
//    if (cellData)
//    {
//        subVC.detailItem = cellData;
//        //        NSArray* arrrrr=self.contCell.collectionData;
//        //        NSLog(@"%@",arrrrr);
//        [self.navigationController pushViewController:subVC animated:YES];
//    }
////    if (arrayWithColl) {
////        subDvc.detailFromContainer=arrayWithColl;
////        // NSLog(@"%@",arrayWithColl);
////    }
//}


@end
